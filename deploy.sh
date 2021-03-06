#!/bin/bash

echo "running ruby tests"
ruby src/ruby/tests/all.rb

echo "deploying to github"
git worktree add /tmp/book gh-pages
mdbook build
rm -rf /tmp/book/*
cp -rp book/* /tmp/book/
cd /tmp/book
git add -A
git commit -m "deployed on $(shell date)"
git push origin gh-pages
cd -
git worktree remove /tmp/book

