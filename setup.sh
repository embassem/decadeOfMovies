#!/bin/bash

#
# USAGE:
# This scripts checks that the necessary tools are installed on the local machine
# and sets up the project so that it can be built with Xcode
#

set -e

function die { ( >&2 echo "$*"); exit 1; }

# CHECK Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    "ℹ️  Installing Homebrew. This might take a while..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
echo "✅  Homebrew is installed willContine to next Step."
fi

echo "ℹ️  Checking formela. This might take a while..."
make bootstrap

# CHECK PREREQUISITES
hash carthage 2>/dev/null || die "Can't find Carthage, please install from https://github.com/Carthage/Carthage"
hash xcodebuild 2>/dev/null || die "Can't find Xcode, please install from the App Store"
hash swiftlint 2>/dev/null || die "Can't find Carthage, please install from https://github.com/realm/SwiftLint"
hash swiftgen 2>/dev/null || die "Can't find Carthage, please install from https://github.com/swiftgen/swiftgen"
xcodebuild -resolvePackageDependencies
echo "✅  project was set up, you can now open it."
