#!/usr/bin/env bash
# verify.sh — Post-setup verification checks

verify_setup() {
    local errors=0

    log_info "Running verification checks..."

    # OpenCode installed
    if ssh_vm "command -v opencode >/dev/null || test -x \$HOME/.local/bin/opencode" &>/dev/null; then
        log_success "OpenCode installed"
    else
        log_error "OpenCode not found"
        errors=$((errors + 1))
    fi

    # nyx-memory installed
    if ssh_vm "command -v nyx-memory" &>/dev/null; then
        log_success "nyx-memory installed"
    else
        log_error "nyx-memory not found"
        errors=$((errors + 1))
    fi

    # nyx-log installed
    if ssh_vm "command -v nyx-log" &>/dev/null; then
        log_success "nyx-log installed"
    else
        log_error "nyx-log not found"
        errors=$((errors + 1))
    fi

    # Config file present
    if ssh_vm "test -f \"${NYX_WORKSPACE}/opencode.json\""; then
        log_success "opencode.json present"
    else
        log_error "opencode.json missing"
        errors=$((errors + 1))
    fi

    # .env present
    if ssh_vm "test -f \"${NYX_WORKSPACE}/.env\""; then
        log_success ".env present"
    else
        log_error ".env missing"
        errors=$((errors + 1))
    fi

    # Skills deployed
    local skill_count
    skill_count=$(ssh_vm "find \"${NYX_WORKSPACE}/.opencode/skills\" -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l" 2>/dev/null || echo "0")
    if (( skill_count > 0 )); then
        log_success "Skills deployed: $skill_count"
    else
        log_warn "No skills found (optional)"
    fi

    # Workspace structure
    if ssh_vm "test -d \"${NYX_WORKSPACE}/engagements\""; then
        log_success "Engagements directory present"
    else
        log_error "Engagements directory missing"
        errors=$((errors + 1))
    fi

    if (( errors > 0 )); then
        log_error "Verification failed with $errors error(s)"
        return 1
    fi

    log_success "All checks passed"
}
