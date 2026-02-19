#!/usr/bin/env bash
# guest.sh — Runs inside Kali VM to install and configure everything
set -euo pipefail

# ── Parse Arguments ──
PROVIDER=""
MODEL=""
SMALL_MODEL=""
API_KEY_ENV=""
API_KEY=""
WORKSPACE="/home/kali/pentest"
ENABLE_EXA="true"
CONFIG_FILE=""
SETUP_DIR="/tmp/nyx-setup"

export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --provider)     PROVIDER="$2";     shift 2 ;;
        --model)        MODEL="$2";        shift 2 ;;
        --small-model)  SMALL_MODEL="$2";  shift 2 ;;
        --api-key-env)  API_KEY_ENV="$2";  shift 2 ;;
        --api-key)      API_KEY="$2";      shift 2 ;;
        --workspace)    WORKSPACE="$2";    shift 2 ;;
        --enable-exa)   ENABLE_EXA="$2";   shift 2 ;;
        --config-file)  CONFIG_FILE="$2";  shift 2 ;;
        --setup-dir)    SETUP_DIR="$2";    shift 2 ;;
        *) echo "Unknown arg: $1"; exit 1 ;;
    esac
done

OPENCODE_DIR="$WORKSPACE/.opencode"

if [[ -n "$CONFIG_FILE" ]]; then
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "[!] Config file not found: $CONFIG_FILE"
        exit 1
    fi
    # shellcheck disable=SC1090
    source "$CONFIG_FILE"
fi

# Validate required config
for required in PROVIDER MODEL SMALL_MODEL API_KEY_ENV API_KEY WORKSPACE ENABLE_EXA; do
    if [[ -z "${!required:-}" ]]; then
        echo "[!] Missing required configuration value: $required"
        exit 1
    fi
done

apt_run() {
    local timeout_secs="$1"
    local description="$2"
    shift 2
    local attempt
    local rc=0

    for attempt in 1 2 3; do
        echo "[*] ${description} (attempt ${attempt}/3)..."
        if timeout "${timeout_secs}" sudo env DEBIAN_FRONTEND=noninteractive \
            apt-get \
            -o Dpkg::Lock::Timeout=300 \
            -o Acquire::Retries=5 \
            -o Acquire::http::Timeout=30 \
            -o Acquire::https::Timeout=30 \
            -o Acquire::ForceIPv4=true \
            "$@"; then
            return 0
        fi

        rc=$?
        if [[ "$rc" -eq 124 ]]; then
            echo "[!] ${description} timed out after ${timeout_secs}s"
        else
            echo "[!] ${description} failed with exit code ${rc}"
        fi

        if [[ "$attempt" -lt 3 ]]; then
            echo "[*] Retrying in 5 seconds..."
            sleep 5
        fi
    done

    return "$rc"
}

resolve_npm_cmd() {
    if command -v npm &>/dev/null; then
        NPM_CMD=(sudo "$(command -v npm)")
        return 0
    fi

    local npm_cli=""
    for candidate in /usr/bin/npm-cli.js /usr/share/nodejs/npm/bin/npm-cli.js; do
        if [[ -f "$candidate" ]]; then
            npm_cli="$candidate"
            break
        fi
    done

    if [[ -n "$npm_cli" ]] && command -v node &>/dev/null; then
        NPM_CMD=(sudo "$(command -v node)" "$npm_cli")
        return 0
    fi

    return 1
}

echo "[*] Starting guest provisioning..."

# ── 1. Update system and install all Kali tools ──
apt_run 900 "Updating system package lists" update
apt_run 3600 "Upgrading installed packages" upgrade -y
echo "[*] Installing Kali tools..."
apt_run 7200 "Installing kali-linux-default toolset" install -y kali-linux-default

# ── 2. Install Node.js/npm if not present ──

if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
    echo "[*] Installing Node.js and npm..."
    apt_run 1800 "Installing Node.js and npm" install -y nodejs npm
fi
hash -r

if ! command -v node &>/dev/null; then
    echo "[!] Node.js not found after installation attempt"
    exit 1
fi

NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]" 2>/dev/null || echo "0")
if (( NODE_MAJOR < 20 )); then
    echo "[!] Detected Node.js $(node -v 2>/dev/null || echo unknown)."
    echo "[!] If nyx-memory install fails, upgrade Node.js to 20+ and rerun setup."
fi

declare -a NPM_CMD=()
if ! resolve_npm_cmd; then
    echo "[!] npm not found after installation attempt"
    echo "[!] Install npm manually (apt-get install -y npm) and rerun setup"
    exit 1
fi

# ── 3. Install OpenCode ──
if ! command -v opencode &>/dev/null; then
    echo "[*] Installing OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
    hash -r
fi

# Store API key in OpenCode's auth.json (avoids env var namespace conflicts)
echo "[*] Configuring OpenCode auth..."
OPENCODE_AUTH_DIR="$HOME/.local/share/opencode"
mkdir -p "$OPENCODE_AUTH_DIR"
python3 -c "
import json, os
auth_file = os.path.join('$OPENCODE_AUTH_DIR', 'auth.json')
auth = {}
if os.path.isfile(auth_file):
    with open(auth_file) as f:
        auth = json.load(f)
auth['$PROVIDER'] = {'type': 'api', 'key': '$API_KEY'}
with open(auth_file, 'w') as f:
    json.dump(auth, f, indent=2)
"
chmod 600 "$OPENCODE_AUTH_DIR/auth.json"

# ── 4. Install nyx-memory ──
if ! command -v nyx-memory &>/dev/null; then
    echo "[*] Installing nyx-memory..."
    "${NPM_CMD[@]}" install -g nyx-memory
fi

if ! command -v nyx-log &>/dev/null; then
    echo "[!] nyx-log not found after nyx-memory install"
    exit 1
fi

# ── 5. Create workspace structure ──
echo "[*] Creating workspace..."
mkdir -p "$WORKSPACE"
mkdir -p "$WORKSPACE/playbooks"
mkdir -p "$WORKSPACE/engagements"

# ── 6. Generate .env ──
echo "[*] Writing .env..."
{
    echo "# Nyx Configuration"
    printf 'NYX_DATA_DIR=%q\n' "${WORKSPACE}/engagements"
    printf 'OPENCODE_ENABLE_EXA=%q\n' "$ENABLE_EXA"
} > "$WORKSPACE/.env"
chmod 600 "$WORKSPACE/.env"

# ── 7. Generate opencode.json from template ──
echo "[*] Generating opencode.json..."

# Build instructions list from prompt files
INSTRUCTIONS=""
if [[ -d "$SETUP_DIR/prompts" ]]; then
    first=true
    for f in "$SETUP_DIR/prompts"/*.md; do
        [[ -f "$f" ]] || continue
        basename_f=$(basename "$f")
        # Copy prompt file to workspace
        cp "$f" "$WORKSPACE/$basename_f"
        if $first; then
            INSTRUCTIONS="\"$basename_f\""
            first=false
        else
            INSTRUCTIONS="$INSTRUCTIONS, \"$basename_f\""
        fi
    done
fi

escape_sed_replacement() {
    printf '%s' "$1" | sed -e 's/[&|\\]/\\&/g'
}

# Process template
cp "$SETUP_DIR/templates/opencode.json.template" "$WORKSPACE/opencode.json"
PROVIDER_ESC=$(escape_sed_replacement "$PROVIDER")
MODEL_ESC=$(escape_sed_replacement "$MODEL")
SMALL_MODEL_ESC=$(escape_sed_replacement "$SMALL_MODEL")
API_KEY_ENV_ESC=$(escape_sed_replacement "$API_KEY_ENV")
WORKSPACE_ESC=$(escape_sed_replacement "$WORKSPACE")
INSTRUCTIONS_ESC=$(escape_sed_replacement "$INSTRUCTIONS")
sed -i \
    -e "s|{{PROVIDER}}|${PROVIDER_ESC}|g" \
    -e "s|{{MODEL}}|${MODEL_ESC}|g" \
    -e "s|{{SMALL_MODEL}}|${SMALL_MODEL_ESC}|g" \
    -e "s|{{API_KEY_ENV_VAR}}|${API_KEY_ENV_ESC}|g" \
    -e "s|{{WORKSPACE}}|${WORKSPACE_ESC}|g" \
    -e "s|{{INSTRUCTIONS}}|${INSTRUCTIONS_ESC}|g" \
    "$WORKSPACE/opencode.json"

# ── 8. Copy tool reference docs ──
TOOL_DOCS_DIR="$WORKSPACE/tool-docs"
if [[ -d "$SETUP_DIR/skills" ]]; then
    echo "[*] Deploying tool reference docs..."
    mkdir -p "$TOOL_DOCS_DIR"
    count=0
    for item in "$SETUP_DIR/skills"/*; do
        [[ -e "$item" ]] || continue
        if [[ -d "$item" ]]; then
            for md in "$item"/*.md; do
                [[ -f "$md" ]] || continue
                cp "$md" "$TOOL_DOCS_DIR/$(basename "$item").md"
                count=$((count + 1))
                break
            done
        elif [[ -f "$item" ]] && [[ "$item" == *.md ]]; then
            cp "$item" "$TOOL_DOCS_DIR/"
            count=$((count + 1))
        fi
    done
    echo "[*] Deployed $count tool docs"
fi

# ── 9. Copy playbooks ──
if [[ -d "$SETUP_DIR/commands" ]]; then
    for f in "$SETUP_DIR/commands"/*.md; do
        [[ -f "$f" ]] || continue
        cp "$f" "$WORKSPACE/playbooks/"
    done
fi

# ── 10. Source .env in shell rc files ──
NYX_RC_BLOCK="$(cat <<RCEOF

# nyx-env
set -a
source "$WORKSPACE/.env"
set +a
export PATH="\$HOME/.local/bin:\$HOME/.opencode/bin:\$PATH"
RCEOF
)"
MARKER="# nyx-env"
for rcfile in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [[ -f "$rcfile" ]] || continue
    if ! grep -q "$MARKER" "$rcfile" 2>/dev/null; then
        echo "[*] Adding .env to $(basename "$rcfile")..."
        printf '%s\n' "$NYX_RC_BLOCK" >> "$rcfile"
    fi
done

# ── 11. Verify ──
echo "[*] Verifying installation..."

errors=0

if ! command -v opencode &>/dev/null; then
    if [[ -x "$HOME/.opencode/bin/opencode" ]]; then
        echo "[*] opencode found at $HOME/.opencode/bin/opencode"
    elif [[ -x "$HOME/.local/bin/opencode" ]]; then
        echo "[*] opencode found at $HOME/.local/bin/opencode"
    else
        echo "[!] opencode not found in PATH"
        errors=$((errors + 1))
    fi
fi

if ! command -v nyx-memory &>/dev/null; then
    echo "[!] nyx-memory not found in PATH"
    errors=$((errors + 1))
fi

if ! command -v nyx-log &>/dev/null; then
    echo "[!] nyx-log not found in PATH"
    errors=$((errors + 1))
fi

if [[ ! -f "$WORKSPACE/opencode.json" ]]; then
    echo "[!] opencode.json not found"
    errors=$((errors + 1))
fi

if [[ ! -f "$WORKSPACE/.env" ]]; then
    echo "[!] .env not found"
    errors=$((errors + 1))
fi

if (( errors > 0 )); then
    echo "[!] Guest provisioning completed with $errors error(s)"
    exit 1
fi

# Cleanup
rm -rf "$SETUP_DIR"

echo "[+] Guest provisioning complete!"
