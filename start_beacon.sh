#!/bin/bash

if [ "$1" == "mainnet" ]; then
  nohup ./beacon-chain --accept-terms-of-use \
  --datadir=/appl/stratisEVM/data/mainnet/beacon \
  --execution-endpoint=http://127.0.0.1:8551 \
  --jwt-secret=/appl/stratisEVM/config/mainnet/jwtsecret\
  --suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552 > beacon_mainnet.out 2>&1 &
fi
nohup ./beacon-chain --auroria --accept-terms-of-use \
  --datadir=/appl/stratisEVM/data/testnet/beacon \
  --execution-endpoint=http://127.0.0.1:8551 \
  --jwt-secret=/appl/stratisEVM/config/testnet/jwtsecret\
  --suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552 > beacon.out 2>&1 &
