#!/bin/bash

if [ "$1" == "mainnet" ]; then
  nohup ./geth --http --http.api eth,net,engine,admin \
    --datadir=/appl/stratisEVM/data/mainnet/geth \
    --authrpc.addr=127.0.0.1 \
    --authrpc.jwtsecret=/appl/stratisEVM/config/mainnet/jwtsecret\
    --syncmode=full > geth_mainnet.out 2>&1 &
fi
nohup ./geth --auroria --http --http.api eth,net,engine,admin \
  --datadir=/appl/stratisEVM/data/testnet/geth \
  --authrpc.addr=127.0.0.1 \
  --authrpc.jwtsecret=/appl/stratisEVM/config/testnet/jwtsecret\
  --syncmode=full > geth.out 2>&1 &
