#!/bin/bash

# This script performs the download and starts geth, beacon, and validator with a provided ETH address.

read -p "Choose network (mainnet/testnet): " NETWORK_CHOICE
NETWORK_CHOICE=$(echo "$NETWORK_CHOICE" | tr '[:upper:]' '[:lower:]')
if [ "$NETWORK_CHOICE" != "mainnet" ] && [ "$NETWORK_CHOICE" != "testnet" ]; then
  echo "Error: Invalid network choice. Please enter 'mainnet' or 'testnet'."
  exit 1
fi
if [ "$NETWORK_CHOICE" == "testnet" ]; then
  CHAIN="auroria"
elif [ "$NETWORK_CHOICE" == "mainnet" ]; then
  CHAIN="mainnet"
fi

read -p "Enter ETH address: " ETH_ADDRESS
if [ -z "$ETH_ADDRESS" ]; then
  echo "Error: No ETH address entered."
  exit 1
fi

read -p "Enter home directory [default: $HOME/stratisevm]: " HOMEDIR
HOMEDIR=${HOMEDIR:-$HOME/stratisevm}

echo "Creating directories..."
mkdir -p "$HOMEDIR"/{config/{mainnet,testnet},data/{mainnet,testnet},bin}
echo "Done."
echo ""
echo "Move scripts to new home directory..."
mv *.sh "$HOMEDIR"/bin/
cd "$HOMEDIR"/bin/
echo "Done."
echo ""
echo "Downloading binaries..."
/bin/bash ./download_bin.sh
echo "Done."
echo ""
echo "Setting up new key..."
./deposit new-mnemonic --num_validators=1 --mnemonic_language=english --chain=$CHAIN --eth1_withdrawal_address=$ETH_ADDRESS
echo "Done."
echo ""
echo "Importing validator keys..."
mv "$HOMEDIR"/bin/validator_keys "$HOMEDIR"/config/$NETWORK_CHOICE/validator_keys
read -sp "Enter your wallet password: " WALLET_PASSWORD
echo $WALLET_PASSWORD > "$HOMEDIR/config/$NETWORK_CHOICE/walletpass"
if [ "$NETWORK_CHOICE" == "mainnet" ]; then
  ./validator accounts import --accept-terms-of-use --keys-dir="$HOMEDIR"/config/$NETWORK_CHOICE/validator_keys --wallet-dir="$HOMEDIR"/config/$NETWORK_CHOICE/wallet --wallet-password-file="$HOMEDIR"/config/$NETWORK_CHOICE/walletpass
else
  ./validator accounts import --accept-terms-of-use --auroria --keys-dir="$HOMEDIR"/config/$NETWORK_CHOICE/validator_keys --wallet-dir="$HOMEDIR"/config/$NETWORK_CHOICE/wallet --wallet-password-file="$HOMEDIR"/config/$NETWORK_CHOICE/walletpass
fi
echo "Done."
echo ""
echo "Setting up config..."
sed -i "s|/appl/stratisEVM|$HOMEDIR|g" "$HOMEDIR/bin/start_validator.sh"
sed -i "s|/appl/stratisEVM|$HOMEDIR|g" "$HOMEDIR/bin/start_geth.sh"
sed -i "s|/appl/stratisEVM|$HOMEDIR|g" "$HOMEDIR/bin/start_beacon.sh"
sed -i "s/--suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552/--suggested-fee-recipient=$ETH_ADDRESS/" "$HOMEDIR/bin/start_validator.sh"
sed -i "s/--suggested-fee-recipient=0x0997e609f67204fcf528e1a78169F8d5FEf8f552/--suggested-fee-recipient=$ETH_ADDRESS/" "$HOMEDIR/bin/start_beacon.sh"
echo "Done."
echo ""
echo "Your Validator ETH address is: $ETH_ADDRESS"
echo "Your Validator keys is in: $HOMEDIR/config/$NETWORK_CHOICE/validator_keys/"
echo "Your Wallet is in: $HOMEDIR/config/$NETWORK_CHOICE/wallet"
echo "Your Wallet password is in: $HOMEDIR/config/$NETWORK_CHOICE/walletpass"
echo "Current directory is: `pwd`"
echo ""
read -p "Do you want to start geth, beacon, and validator services now? [Y/n]: " START_CONFIRMATION
START_CONFIRMATION=$(echo "$START_CONFIRMATION" | tr '[:upper:]' '[:lower:]')
if [[ "$START_CONFIRMATION" == "y" || "$START_CONFIRMATION" == "yes" || -z "$START_CONFIRMATION" ]]; then
  echo "Starting geth..."
  ./start_geth.sh $NETWORK_CHOICE
  echo "Done."
  echo ""
  sleep 5
  echo "Starting beacon..."
  ./start_beacon.sh $NETWORK_CHOICE
  echo "Done."
  echo ""
  echo "Starting validator..."
  ./start_validator.sh $NETWORK_CHOICE
  echo "Done."
else
  echo "Services will not be started now."
fi
