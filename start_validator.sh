#!/bin/bash

if [ "$1" == "mainnet" ]; then
  nohup ./validator --accept-terms-of-use \
    --wallet-dir=/appl/stratisEVM/config/mainnet/wallet \
    --wallet-password-file=/appl/stratisEVM/config/mainnet/walletpass \
    --suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552 > validator_mainnet.out 2>&1 &
fi
nohup ./validator \
  --accept-terms-of-use --auroria \
  --wallet-dir=/appl/stratisEVM/config/testnet/wallet \
  --wallet-password-file=/appl/stratisEVM/config/testnet/walletpass \
  --suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552 > validator.out 2>&1 &
