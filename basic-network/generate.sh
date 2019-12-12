#!/bin/sh
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
export PATH=$GOPATH/src/github.com/hyperledger/fabric/build/bin:${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
CHANNEL1_NAME=vetter
CHANNEL2_NAME=enterprise
CHANNEL3_NAME=telephonenumber
CHANNEL4_NAME=tnprovider

# remove previous crypto material and config transactions
rm -fr config/*
rm -fr crypto-config/*

# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate genesis block for orderer
configtxgen -profile OrdererGenesis -outputBlock ./config/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

# generate channel configuration transactions
configtxgen -profile OrgOneChannel -outputCreateChannelTx ./config/${CHANNEL1_NAME}_channel.tx -channelID $CHANNEL1_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

configtxgen -profile OrgTwoChannel -outputCreateChannelTx ./config/${CHANNEL2_NAME}_channel.tx -channelID $CHANNEL2_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

configtxgen -profile OrgThreeChannel -outputCreateChannelTx ./config/${CHANNEL3_NAME}_channel.tx -channelID $CHANNEL3_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

configtxgen -profile OrgThreeChannel -outputCreateChannelTx ./config/${CHANNEL4_NAME}_channel.tx -channelID $CHANNEL4_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

# generate anchor peer transaction
configtxgen -profile OrgOneChannel -outputAnchorPeersUpdate ./config/${CHANNEL1_NAME}_Org1MSPanchors.tx -channelID $CHANNEL1_NAME -asOrg Org1MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org1MSP..."
  exit 1
fi

configtxgen -profile OrgTwoChannel -outputAnchorPeersUpdate ./config/${CHANNEL2_NAME}_Org2MSPanchors.tx -channelID $CHANNEL2_NAME -asOrg Org2MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org2MSP..."
  exit 1
fi

configtxgen -profile OrgThreeChannel -outputAnchorPeersUpdate ./config/${CHANNEL3_NAME}_Org3MSPanchors.tx -channelID $CHANNEL3_NAME -asOrg Org3MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org3MSP..."
  exit 1
fi

configtxgen -profile OrgThreeChannel -outputAnchorPeersUpdate ./config/${CHANNEL4_NAME}_Org3MSPanchors.tx -channelID $CHANNEL4_NAME -asOrg Org3MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org3MSP..."
  exit 1
fi