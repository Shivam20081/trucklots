#!/usr/bin/Env bash

# Removes all local saved state and lock files.

find . -name ".terraform" -exec rm -rf {} \;
find . -name "*.lock.hcl" -delete
find . -name "*.tfstate" -delete
find . -name "*.tfstate.backup" -delete
find . -name "*.pfx" -delete