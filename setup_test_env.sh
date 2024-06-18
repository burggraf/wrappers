#!/bin/bash

# Install Rust Toolchain
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Install pgrx dependencies
# brew install git icu4c pkg-config
sudo apt-get install git icu4c pkg-config

# Install pgrx
cargo install cargo-pgrx --version 0.11.3 --locked
cargo pgrx init

# Run the helloworld wrapper as a test
cd wrappers/wrappers
cargo pgrx run pg15 --features helloworld_fdw
