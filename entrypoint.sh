#!/bin/sh -l
set -e

cd "$GITHUB_WORKSPACE" || exit

excludes=$(echo $1 | sed 's/ /\\\|/g')
echo "==> Finding .{c,h,cpp,hpp} files"
echo "    (exclude directories: $excludes)"
src=$(git ls-tree --full-tree -r HEAD | grep -e "\.\(c\|h\|hpp\|cpp\)\$" | cut -f 2 | grep -ve "^\($excludes\)/")

echo "==> Configuring Git author"
git config --global user.email clang-format@wisc.space
git config --global user.name "Clang-Format"

clang-format -style=file -i $src

echo "==> Committing style changes"
git commit -a -m 'apply clang-format' || true

echo "==> pushing to $BRANCH"
git push -u origin $BRANCH
