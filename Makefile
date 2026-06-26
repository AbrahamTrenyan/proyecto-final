-include .env

AUX = --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast 
AUX_ETHERSCAN = --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) 

deploy-busd:
	forge script script/DeployBUSD.s.sol:DeployBUSD $(AUX_ETHERSCAN)
deploy-ccnft:
	forge script script/DeployCCNFT.s.sol:DeployCCNFT $(AUX_ETHERSCAN)