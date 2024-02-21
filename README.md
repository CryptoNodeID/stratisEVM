### Prerequisite :
#### Ensure 'tar' and 'unzip' already installed
    apt-get update && apt-get install tar unzip -y

### Steps :
#### Download the release :
    wget https://github.com/CryptoNodeID/stratisEVM/releases/download/0.1.1/v0.1.1.zip && unzip v0.1.1.zip -d stratisEVM
#### run setup command : 
    cd stratisEVM && chmod ug+x *.sh && ./setup.sh
#### follow the instruction and your node will be ready in no time
