#!/bin/sh

#==================================================================================================================
# 
#==================================================================================================================
faucet_provision()
{
	# Create directories required by faucet docker container 
  # as per https://docs.openvswitch.org/en/latest/tutorials/faucet/
	mkdir inst

  # Set Dockerfile to use for container build
  cp Dockerfile.faucet Dockerfile
}

#==================================================================================================================
# 
#==================================================================================================================
faucet_docker_container_build()
{
	# Build docker container
	docker build -t faucet/faucet .
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
		-v $(pwd)/inst/:/etc/faucet/ \
		-v $(pwd)/inst/:/var/log/faucet/ \
		-p 6653:6653 \
		-p 9302:9302 \
		faucet/faucet
}

