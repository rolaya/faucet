#!/bin/sh

#==================================================================================================================
# 
#==================================================================================================================
faucet_provision()
{
	# Create directories required by faucet docker container 
	sudo mkdir -p /etc/faucet
	sudo mkdir -p /var/log/faucet/
	sudo cp provision/faucet.yaml /etc/faucet/faucet.yaml
	sudo chmod a+w /etc/faucet/faucet.yaml
}

#==================================================================================================================
# 
#==================================================================================================================
faucet_docker_container_build()
{
	# Build docker container
	docker build -t faucet/faucet adapters/vendors/faucetagent
}

#==================================================================================================================
# 
#==================================================================================================================
faucet_start()
{
	# Run faucet docker container 
	docker run -d \
		--name faucet \
		--restart=always \
		-v /etc/faucet/:/etc/faucet/ \
		-v /var/log/faucet/:/var/log/faucet/ \
		-p 6653:6653 \
		-p 9302:9302 \
		faucet/faucet
}

