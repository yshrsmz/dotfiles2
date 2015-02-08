#!/bin/bash

trap 'echo Error: $0: stopped; exit 1' ERR INT
set -u
set -e

# judge if installing homebrew is necessary
if [[ $OSTYPE != darwin* ]]; then
    exit 0
fi
if type brew > /dev/null 2>$1; then
    exit 0
fi

if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi

echo 'brew: command not found' 1>$2
echo -n 'Install now? (y/N) '
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    ruby -e "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
