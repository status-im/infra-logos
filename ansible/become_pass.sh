#!/usr/bin/env bash
# Used via BECOME_PASSWORD_FILE to avoid re-evaluation on every task.
gopass show -o "users/${IFT_REMOTE_USER:-$USER}/sudo"
