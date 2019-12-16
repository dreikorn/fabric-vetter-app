# Education
Simple Hyperledger app to showcase referential data for STIR/SHAKEN

Clone the repo

install all needed docker containers through 

	curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh | bash -s 1.4.4 

Import the Go files in directory chaincode as a project and ensure you set project gopath to chaincode/gopath. Ensure you are NOT using the system defined Gopath for the project. Let IntelliJ run go get for all dependencies

go to vetter-node-app

Start the Docker containers and deploy your Chaincode through

`./startFabric`

If you want to deploy future chaincode changes do

	docker stop $(docker ps -aq)
	docker rm -f $(docker ps -aq)
	docker rmi of all containers that have a long hash in their name
	#Rerun ./startFabric.sh

Run the init scripts

    npm install
    
for the nodeJS app and afterwards perform

    ./registerAdmin.js
    ./registerUser.js
    
And start the server with
    
    ./server.js