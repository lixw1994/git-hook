#!/bin/sh

# ignore merge request
MERGE_MSG=$(grep -E '^Merge *' "$1")

if [ "$MERGE_MSG" != "" ]; then
    exit 0
fi

# must start with feat, fix, refactor, chore
COMMIT_MSG=$(grep -E  "^(feat|fix|refactor|chore)(\(\w+\))?:\s(\S|\w)+" "$1")

if [ "$COMMIT_MSG" = "" ]; then
    printf "Commit Message must start with feat, fix, refactor, chore !\n"
    printf "Example: feat: 新增功能\n"
    printf "Example: fix: 修复 BUG\n"
    printf "Example: refactor: 功能重构\n"
    printf "Example: chore: 期望不影响功能的杂项 如文档、注释、测试等\n"
    exit 1
fi

if [ ${#COMMIT_MSG} -lt 15 ]; then
    printf "Commit Message Too Short. Please show me more detail!\n"
    exit 1
fi
