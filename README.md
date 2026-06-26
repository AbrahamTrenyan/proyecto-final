# Blockchain: Proyecto Final 
# CryptoCampo NFT

Sistema de NFTs sobre Ethereum (testnet **Sepolia**) que funciona como una mini economía:
un token ERC-20 propio (**BUSD**) se usa como moneda para comprar, vender, intercambiar y
reclamar NFTs (**CCNFT**, estándar ERC-721) que tokenizan bienes agrícolas.

## Contratos

- **BUSD** (`src/BUSD.sol`): token ERC-20 que actúa como moneda de cambio del sistema.
  En el deploy se mintean 10.000.000 BUSD al deployer.
- **CCNFT** (`src/CCNFT.sol`): contrato ERC-721 con la lógica económica. Cada NFT tiene un
  valor asociado y el contrato permite:
  - `buy`: comprar NFTs pagando con BUSD (más una tarifa de compra).
  - `putOnSale` / `trade`: poner un NFT en venta e intercambiarlo entre usuarios.
  - `claim`: reclamar NFTs para recuperar los fondos (con un porcentaje de beneficio).
  - Setters administrativos (`onlyOwner`) para configurar tarifas, valores válidos,
    colectores de fondos/tarifas y los flags `canBuy` / `canTrade` / `canClaim`.
  - Protección contra reentrancy (`ReentrancyGuard`) y transferencias directas
    deshabilitadas para forzar el flujo a través de `trade`.

## Despliegue en Sepolia

| Contrato | Dirección | Etherscan |
|---|---|---|
| **BUSD** | `0xA073c37D96a375fd176144b9D248b06966ca0d8C` | [Ver contrato](https://sepolia.etherscan.io/address/0xA073c37D96a375fd176144b9D248b06966ca0d8C) |
| **CCNFT** | `0xF91E56dCb0F0229FA12C29b50D4fB70cB76D96c0` | [Ver contrato](https://sepolia.etherscan.io/address/0xF91E56dCb0F0229FA12C29b50D4fB70cB76D96c0) |

Ambos contratos están **verificados** en Etherscan (código fuente público).

- **Owner / deployer:** `0xCd81faf98327B03bd9f783538414fA0400FF8bf2`
- **Tx de despliegue BUSD:** [`0xe1edfe4f...59db6742`](https://sepolia.etherscan.io/tx/0xe1edfe4f2c3812c97fd54fd01656294aa015a8b0488190e7dd09956059db6742)
- **Tx de despliegue CCNFT:** [`0x686e52c6...da845c53`](https://sepolia.etherscan.io/tx/0x686e52c6cbdcf2b85600aacbbe7524bd72e5401b45112281b8b8e014da845c53)

## Interacciones realizadas

Flujo ejecutado on-chain para concretar la compra de un NFT:

1. `approve` en BUSD autorizando al contrato CCNFT a gastar los BUSD.
2. Configuración del CCNFT (owner): `setFundsToken`, `setFundsCollector`, `setFeesCollector`,
   `setCanBuy(true)`, `addValidValues`, `setMaxBatchCount`, `setMaxValueToRaise`, `setBuyFee`.
3. `buy(value, amount)` → se minteó el **NFT tokenId 0** al comprador.

## Capturas (MetaMask, red Sepolia)

NFT CCNFT importado (tokenId 0, ERC-721):

![NFT CCNFT en MetaMask](img/nft-ccnft-metamask.jpg)

Tokens BUSD importados (10.000.000 BUSD):

![BUSD en MetaMask](img/busd-metamask.jpg)

## Comandos

```shell
# Compilar
forge build

# Tests
forge test

# Formato
forge fmt

# Deploy + verificación (requiere variables en .env)
make deploy-busd
make deploy-ccnft
```

### Variables de entorno (`.env`)

```
SEPOLIA_RPC_URL=...
PRIVATE_KEY=0x...
API_KEY_ETHERSCAN=...
```

## Stack

- [Foundry](https://book.getfoundry.sh/) (Forge, Cast)
- OpenZeppelin Contracts v4.5.0
- Solidity ^0.8.19
