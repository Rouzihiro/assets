#!/usr/bin/env bash
# switch-to-ssh.sh
# Switch the current git repo to use SSH for GitHub

# Make sure you are in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not inside a git repository!" >&2
    exit 1
fi

# Set the SSH remote URL
git remote set-url origin git@github.com:Rouzihiro/assets.git

# Show the new remote URL
git remote -v
echo "✅ Remote switched to SSH"
