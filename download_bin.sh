#!/bin/bash

wget https://github.com/stratisproject/go-stratis/releases/download/0.1.1/geth-linux-amd64-5c4504c.tar.gz
wget https://github.com/stratisproject/prysm-stratis/releases/download/0.1.1/beacon-chain-linux-amd64-0ebd251.tar.gz
wget https://github.com/stratisproject/prysm-stratis/releases/download/0.1.1/prysmctl-linux-amd64-0ebd251.tar.gz
wget https://github.com/stratisproject/prysm-stratis/releases/download/0.1.1/validator-linux-amd64-0ebd251.tar.gz
wget https://github.com/stratisproject/staking-deposit-cli/releases/download/0.1.0/staking-deposit-cli-linux-amd64.zip

for _file in *.zip; do unzip -j "$_file"; done
for _file in *.tar.gz; do tar -xvzf "$_file"; done

rm -f *.zip
rm -f *.tar.gz