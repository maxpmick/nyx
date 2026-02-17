#!/usr/bin/env bash
# tui.sh — TUI abstraction: gum → whiptail → basic read/echo

# ── Backend detection ──
TUI_BACKEND=""
_tui_detect() {
    [[ -n "$TUI_BACKEND" ]] && return
    if command -v gum &>/dev/null; then
        TUI_BACKEND="gum"
    elif command -v whiptail &>/dev/null; then
        TUI_BACKEND="whiptail"
    else
        TUI_BACKEND="basic"
    fi
}

# ── tui_style — styled header text ──
# Usage: tui_style "Header Text"
tui_style() {
    _tui_detect
    local text="$1"
    case "$TUI_BACKEND" in
        gum)
            gum style --foreground 212 --bold "$text"
            ;;
        *)
            printf "${MAGENTA}${BOLD}%s${RESET}\n" "$text"
            ;;
    esac
}

# ── tui_choose — single-select menu ──
# Usage: tui_choose "Prompt" option1 option2 ...
# Returns: selected value on stdout
tui_choose() {
    _tui_detect
    local prompt="$1"; shift
    local options=("$@")

    case "$TUI_BACKEND" in
        gum)
            printf '%s\n' "${options[@]}" | gum choose --header "$prompt"
            ;;
        whiptail)
            local -a menu_args=()
            local i=1
            for opt in "${options[@]}"; do
                menu_args+=("$i" "$opt")
                ((i++))
            done
            local rows=$(( ${#options[@]} + 8 ))
            (( rows > 20 )) && rows=20
            local selected
            selected=$(whiptail --title "Nyx" --menu "$prompt" "$rows" 60 ${#options[@]} \
                "${menu_args[@]}" 3>&1 1>&2 2>&3) || return 1
            if [[ "$selected" =~ ^[0-9]+$ ]] && (( selected >= 1 && selected <= ${#options[@]} )); then
                printf '%s' "${options[$((selected-1))]}"
            else
                return 1
            fi
            ;;
        basic)
            printf "${CYAN}%s${RESET}\n" "$prompt" >&2
            local i=1
            for opt in "${options[@]}"; do
                printf "  ${BOLD}%d)${RESET} %s\n" "$i" "$opt" >&2
                ((i++))
            done
            local choice
            while true; do
                printf "${CYAN}> ${RESET}" >&2
                read -r choice
                if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
                    printf '%s' "${options[$((choice-1))]}"
                    return
                fi
                printf "  Invalid choice. Enter 1-%d.\n" "${#options[@]}" >&2
            done
            ;;
    esac
}

# ── tui_input — text input ──
# Usage: tui_input "Prompt" [default]
# Returns: entered text on stdout
tui_input() {
    _tui_detect
    local prompt="$1"
    local default="${2:-}"

    case "$TUI_BACKEND" in
        gum)
            local args=(--header "$prompt" --placeholder "$default")
            [[ -n "$default" ]] && args+=(--value "$default")
            gum input "${args[@]}"
            ;;
        whiptail)
            whiptail --title "Nyx" --inputbox "$prompt" 10 60 "$default" 3>&1 1>&2 2>&3
            ;;
        basic)
            if [[ -n "$default" ]]; then
                printf "${CYAN}%s${RESET} [%s]: " "$prompt" "$default" >&2
            else
                printf "${CYAN}%s${RESET}: " "$prompt" >&2
            fi
            local value
            read -r value
            printf '%s' "${value:-$default}"
            ;;
    esac
}

# ── tui_password — masked input ──
# Usage: tui_password "Prompt"
# Returns: entered text on stdout
tui_password() {
    _tui_detect
    local prompt="$1"

    case "$TUI_BACKEND" in
        gum)
            gum input --header "$prompt" --password
            ;;
        whiptail)
            whiptail --title "Nyx" --passwordbox "$prompt" 10 60 3>&1 1>&2 2>&3
            ;;
        basic)
            printf "${CYAN}%s${RESET}: " "$prompt" >&2
            local value
            read -rs value
            printf '\n' >&2
            printf '%s' "$value"
            ;;
    esac
}

# ── tui_confirm — yes/no ──
# Usage: tui_confirm "Question?"
# Returns: exit code 0=yes, 1=no
tui_confirm() {
    _tui_detect
    local prompt="$1"
    local default="${2:-yes}"

    case "$TUI_BACKEND" in
        gum)
            if [[ "$default" == "no" ]]; then
                gum confirm --default=false "$prompt"
            else
                gum confirm "$prompt"
            fi
            ;;
        whiptail)
            if [[ "$default" == "no" ]]; then
                whiptail --title "Nyx" --defaultno --yesno "$prompt" 10 60
            else
                whiptail --title "Nyx" --yesno "$prompt" 10 60
            fi
            ;;
        basic)
            local yn
            if [[ "$default" == "no" ]]; then
                printf "${CYAN}%s${RESET} [y/N]: " "$prompt" >&2
            else
                printf "${CYAN}%s${RESET} [Y/n]: " "$prompt" >&2
            fi
            read -r yn
            case "${yn,,}" in
                y|yes) return 0 ;;
                n|no)  return 1 ;;
                "")
                    [[ "$default" == "yes" ]] && return 0 || return 1
                    ;;
                *)
                    [[ "$default" == "yes" ]] && return 0 || return 1
                    ;;
            esac
            ;;
    esac
}

# ── tui_spin — spinner wrapping a command ──
# Usage: tui_spin "Message..." command [args...]
tui_spin() {
    _tui_detect
    local msg="$1"; shift

    case "$TUI_BACKEND" in
        gum)
            gum spin --spinner dot --title "$msg" -- "$@"
            ;;
        *)
            local pid
            printf "${CYAN}  ⠋ %s${RESET}" "$msg" >&2

            # Run command in background, capture output for errors
            local logfile
            logfile=$(mktemp)
            "$@" >"$logfile" 2>&1 &
            pid=$!

            local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
            local i=0
            while kill -0 "$pid" 2>/dev/null; do
                printf "\r${CYAN}  %s %s${RESET}" "${frames[$i]}" "$msg" >&2
                i=$(( (i + 1) % ${#frames[@]} ))
                sleep 0.1
            done

            wait "$pid"
            local exit_code=$?

            if (( exit_code == 0 )); then
                printf "\r${GREEN}  ✓ %s${RESET}\n" "$msg" >&2
            else
                printf "\r${RED}  ✗ %s${RESET}\n" "$msg" >&2
                cat "$logfile" >&2
            fi
            rm -f "$logfile"
            return $exit_code
            ;;
    esac
}

# ── tui_banner — show the Nyx banner ──
tui_banner() {
    local banner_file="$NYX_DIR/assets/banner.txt"
    if [[ -f "$banner_file" ]]; then
        printf "${MAGENTA}"
        cat "$banner_file"
        printf "${RESET}\n"
    fi
}
