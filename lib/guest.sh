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

export PATH="$HOME/.local/bin:$PATH"

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
        *) echo "Unknown arg: $1"; exit 1 ;;
    esac
done

SETUP_DIR="/tmp/nyx-setup"
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

echo "[*] Starting guest provisioning..."

# ── 1. Install Node.js/npm if not present ──
if ! command -v node &>/dev/null; then
    echo "[*] Installing Node.js..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq nodejs npm
fi

NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]" 2>/dev/null || echo "0")
if (( NODE_MAJOR < 20 )); then
    echo "[!] Detected Node.js $(node -v 2>/dev/null || echo unknown)."
    echo "[!] If nyx-memory install fails, upgrade Node.js to 20+ and rerun setup."
fi

# ── 2. Install OpenCode ──
if ! command -v opencode &>/dev/null; then
    echo "[*] Installing OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
fi

# ── 3. Install nyx-memory ──
if ! command -v nyx-memory &>/dev/null; then
    echo "[*] Installing nyx-memory..."
    sudo npm install -g nyx-memory
fi

if ! command -v nyx-log &>/dev/null; then
    echo "[!] nyx-log not found after nyx-memory install"
    exit 1
fi

# ── 4. Create workspace structure ──
echo "[*] Creating workspace..."
mkdir -p "$WORKSPACE"
mkdir -p "$OPENCODE_DIR/skills"
mkdir -p "$OPENCODE_DIR/commands"
mkdir -p "$WORKSPACE/engagements"

# ── 5. Generate .env ──
echo "[*] Writing .env..."
{
    echo "# Nyx AI Configuration"
    printf '%s=%q\n' "$API_KEY_ENV" "$API_KEY"
    printf 'NYX_DATA_DIR=%q\n' "${WORKSPACE}/engagements"
    printf 'OPENCODE_ENABLE_EXA=%q\n' "$ENABLE_EXA"
} > "$WORKSPACE/.env"
chmod 600 "$WORKSPACE/.env"

# ── 6. Generate opencode.json from template ──
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

# ── 7. Copy skills ──
if [[ -d "$SETUP_DIR/skills" ]]; then
    echo "[*] Deploying skills..."
    # Skills may be individual .md files or directories containing .md files
    for item in "$SETUP_DIR/skills"/*; do
        [[ -e "$item" ]] || continue
        if [[ -d "$item" ]]; then
            # Directory-based skill: look for .md files inside
            local_name=$(basename "$item")
            for md in "$item"/*.md; do
                [[ -f "$md" ]] || continue
                cp "$md" "$OPENCODE_DIR/skills/${local_name}.md"
                break  # Take first .md file
            done
        elif [[ -f "$item" ]] && [[ "$item" == *.md ]]; then
            cp "$item" "$OPENCODE_DIR/skills/"
        fi
    done
    echo "[*] Deployed $(ls "$OPENCODE_DIR/skills/"*.md 2>/dev/null | wc -l) skills"
fi

# ── 8. Copy commands ──
if [[ -d "$SETUP_DIR/commands" ]]; then
    for f in "$SETUP_DIR/commands"/*.md; do
        [[ -f "$f" ]] || continue
        cp "$f" "$OPENCODE_DIR/commands/"
    done
fi

# ── 9. Source .env in .bashrc ──
BASHRC="$HOME/.bashrc"
MARKER="# nyx-env"
if ! grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
    echo "[*] Adding .env to .bashrc..."
    cat >> "$BASHRC" <<RCEOF

$MARKER
set -a
source "$WORKSPACE/.env"
set +a
export PATH="\$HOME/.local/bin:\$PATH"
RCEOF
fi

# ── 10. Verify ──
echo "[*] Verifying installation..."

errors=0

if ! command -v opencode &>/dev/null; then
    if [[ -x "$HOME/.local/bin/opencode" ]]; then
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
