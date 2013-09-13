#!/bin/sh

RUBY_VERSION=1.9.3-p448
SETUP="rvm ${RUBY_VERSION} do bundle exec"

echo "Ruby, symlinked directory:"
${SETUP} ruby bar/main.rb
echo "Rspec, real directory:"
${SETUP} rspec -o /dev/null foo/main.rb
echo "Rspec, symlinked directory:"
${SETUP} rspec -o /dev/null bar
