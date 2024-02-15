#!/bin/bash
_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ "$1" == "mainnet" ]; then
  nohup ./geth --http --http.api eth,net,engine,admin --datadir=/appl/stratisEVM/data/mainnet/geth --authrpc.addr=$_ip --authrpc.jwtsecret=/appl/stratisEVM/config/mainnet/jwtsecret --syncmode=full > geth_mainnet.out 2>&1 &
fi
nohup ./geth --auroria --http --http.api eth,net,engine,admin --datadir=/appl/stratisEVM/data/testnet/geth --authrpc.addr=$_ip --authrpc.jwtsecret=/appl/stratisEVM/config/testnet/jwtsecret --syncmode=full > geth.out 2>&1 &
