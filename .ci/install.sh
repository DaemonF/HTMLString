#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    gem install xcpretty
fi

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    sudo apt-get update
    sudo apt-get install clang libicu-dev libstdc++6-4.6-dev -f -y
    strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep GLIBCXX
    echo "4.0-DEVELOPMENT-SNAPSHOT-2017-08-31-a" >> .swift-version
fi
