# Education
Simple Hyperledger app to showcase referential data for STIR/SHAKEN

Clone the repo

install all needed docker containers through 
	curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh | bash -s 1.4.4 

go to directory basic-network

Initialize all crypto stores and channels through:
	./init.sh
	./generate.sh

Now you should see the genesis blocks and certificates generated in subdirectories basic-network/config and basic-network/crypto-config

Import the Go files in directory chaincode as a project and ensure you set project gopath to chaincode/gopath

go to vetter-node-app

Start the Docker containers and deploy your Chaincode through
	./startFabric

If you want to deploy future chaincode changes do
	docker stop $(docker ps -aq)
	docker rm -f $(docker ps -aq)
	docker rmi of all containers that have a long hash in their name
	#Rerun ./startFabric.sh
