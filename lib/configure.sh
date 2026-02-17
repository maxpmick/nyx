#!/usr/bin/env bash
# configure.sh — Gather user configuration via TUI

# All config is exported as variables for use by other modules.

# ── VM Configuration ──
configure_vm() {
    tui_style "Virtual Machine Configuration"
    echo

    NYX_VM_NAME=$(tui_input "VM name" "nyx-kali")
    NYX_VM_NAME="${NYX_VM_NAME:-nyx-kali}"
    export NYX_VM_NAME

    local ram_choice
    ram_choice=$(tui_choose "RAM allocation" "4096 MB (recommended)" "2048 MB" "8192 MB")
    NYX_VM_RAM="${ram_choice%% *}"
    export NYX_VM_RAM

    local cpu_choice
    cpu_choice=$(tui_choose "CPU cores" "2 (recommended)" "1" "4")
    NYX_VM_CPUS="${cpu_choice%% *}"
    export NYX_VM_CPUS

    echo
    log_info "VM: ${NYX_VM_NAME} — ${NYX_VM_RAM}MB RAM, ${NYX_VM_CPUS} CPUs"
}

# ── Provider Configuration ──
configure_provider() {
    tui_style "AI Provider Configuration"
    echo

    local provider_choice
    provider_choice=$(tui_choose "Select AI provider" \
        "Anthropic (recommended)" \
        "OpenAI" \
        "Google Gemini" \
        "Groq" \
        "OpenRouter")

    case "$provider_choice" in
        "Anthropic"*)
            NYX_PROVIDER="anthropic"
            NYX_API_KEY_ENV_VAR="ANTHROPIC_API_KEY"
            NYX_DEFAULT_MODEL="claude-sonnet-4-5-20250929"
            NYX_DEFAULT_SMALL_MODEL="claude-haiku-4-5-20251001"
            ;;
        "OpenAI"*)
            NYX_PROVIDER="openai"
            NYX_API_KEY_ENV_VAR="OPENAI_API_KEY"
            NYX_DEFAULT_MODEL="gpt-4o"
            NYX_DEFAULT_SMALL_MODEL="gpt-4o-mini"
            ;;
        "Google"*)
            NYX_PROVIDER="google"
            NYX_API_KEY_ENV_VAR="GEMINI_API_KEY"
            NYX_DEFAULT_MODEL="gemini-2.5-flash"
            NYX_DEFAULT_SMALL_MODEL="gemini-2.5-flash"
            ;;
        "Groq"*)
            NYX_PROVIDER="groq"
            NYX_API_KEY_ENV_VAR="GROQ_API_KEY"
            NYX_DEFAULT_MODEL="llama-3.3-70b"
            NYX_DEFAULT_SMALL_MODEL="llama-3.3-70b"
            ;;
        "OpenRouter"*)
            NYX_PROVIDER="openrouter"
            NYX_API_KEY_ENV_VAR="OPENROUTER_API_KEY"
            NYX_DEFAULT_MODEL=""
            NYX_DEFAULT_SMALL_MODEL=""
            ;;
    esac
    export NYX_PROVIDER NYX_API_KEY_ENV_VAR NYX_DEFAULT_MODEL NYX_DEFAULT_SMALL_MODEL

    # Get API key
    NYX_API_KEY=$(tui_password "Enter your ${NYX_API_KEY_ENV_VAR}")
    if [[ -z "$NYX_API_KEY" ]]; then
        log_error "API key is required."
        exit 1
    fi
    export NYX_API_KEY
}

# ── Model Configuration ──
configure_model() {
    tui_style "Model Configuration"
    echo

    case "$NYX_PROVIDER" in
        anthropic)
            NYX_MODEL=$(tui_choose "Select model" \
                "claude-sonnet-4-5-20250929 (recommended)" \
                "claude-opus-4-6" \
                "claude-haiku-4-5-20251001")
            NYX_MODEL="${NYX_MODEL%% *}"
            NYX_SMALL_MODEL="claude-haiku-4-5-20251001"
            ;;
        openai)
            NYX_MODEL=$(tui_choose "Select model" \
                "gpt-4o (recommended)" \
                "gpt-4o-mini" \
                "o3-mini")
            NYX_MODEL="${NYX_MODEL%% *}"
            NYX_SMALL_MODEL="gpt-4o-mini"
            ;;
        google)
            NYX_MODEL=$(tui_choose "Select model" \
                "gemini-2.5-flash (recommended)" \
                "gemini-2.5-pro")
            NYX_MODEL="${NYX_MODEL%% *}"
            NYX_SMALL_MODEL="gemini-2.5-flash"
            ;;
        groq)
            NYX_MODEL=$(tui_choose "Select model" \
                "llama-3.3-70b (recommended)" \
                "llama-3.1-8b" \
                "mixtral-8x7b-32768")
            NYX_MODEL="${NYX_MODEL%% *}"
            NYX_SMALL_MODEL="$NYX_MODEL"
            ;;
        openrouter)
            NYX_MODEL=$(tui_input "Model ID (e.g. anthropic/claude-sonnet-4-5-20250929)")
            NYX_SMALL_MODEL=$(tui_input "Small model ID (for summaries)" "$NYX_MODEL")
            ;;
    esac

    if [[ -z "${NYX_MODEL:-}" ]]; then
        log_error "Model selection cannot be empty."
        exit 1
    fi
    if [[ -z "${NYX_SMALL_MODEL:-}" ]]; then
        log_error "Small model selection cannot be empty."
        exit 1
    fi
    export NYX_MODEL NYX_SMALL_MODEL

    echo
    log_info "Model: ${NYX_PROVIDER}/${NYX_MODEL}"
}

# ── Search Configuration ──
configure_search() {
    tui_style "Web Search"
    echo

    if tui_confirm "Enable web search (Exa AI, no API key needed)?"; then
        NYX_ENABLE_EXA="true"
        log_info "Web search: enabled"
    else
        NYX_ENABLE_EXA="false"
        log_info "Web search: disabled"
    fi
    export NYX_ENABLE_EXA
    echo
}
