# EnergyTrade - Confidential Energy Trading Platform

## Description

EnergyTrade is a decentralized energy trading platform where energy volumes, prices, and consumption data remain encrypted. Producers and consumers can trade energy without revealing their exact consumption patterns or pricing strategies.

Link: https://enegrytrade.vercel.app/

## Functionality

- Encrypted energy production and consumption tracking
- Private energy trading with encrypted prices
- Confidential grid balancing and load management
- Encrypted billing and payment processing
- Private energy portfolio management
- Public decryption for settlement and verification

## Smart Contracts

- `EnergyMarket.sol` - Main contract for energy trading
- `ProductionTracker.sol` - Contract for encrypted production tracking
- `ConsumptionManager.sol` - Contract for private consumption management

## UI/UX

### Producer Dashboard
- Form to register energy production with encrypted amounts
- List of energy offers with encrypted prices
- Production history (encrypted volumes)
- Revenue tracking (encrypted amounts)

### Consumer Dashboard
- Energy consumption tracking (encrypted)
- List of available energy offers (prices encrypted)
- Purchase history (encrypted amounts)
- Consumption analytics (encrypted metrics)

### Trading Interface
- Order book with encrypted prices
- Trading history (encrypted volumes and prices)
- Settlement interface
- Grid status visualization

## Technical Requirements

- **Technology Stack:**
  - Zama FHEVM v0.9
  - Next.js 16 (App Router)
  - React 19
  - TypeScript
  - Tailwind CSS
  - Wagmi v3 (MetaMask only, using `injected()` connector)
  - Ethers.js v6.8.0
  - @zama-fhe/relayer-sdk v0.3.0

- **Network:** Sepolia Testnet
- **Relayer:** https://relayer.testnet.zama.org

## Deployed Contract Addresses

- **ENERGY_MARKET**: `0xFc86a29F5E80728a2E5226Cb2850A5ddf9150dD6` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0xFc86a29F5E80728a2E5226Cb2850A5ddf9150dD6))
- **PRODUCTION_TRACKER**: `0xE026756cBf5DAA4ef116a9DD4A858d93540A77F8` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0xE026756cBf5DAA4ef116a9DD4A858d93540A77F8))
- **CONSUMPTION_MANAGER**: `0xf2Ef32Ad92E86905d26a8488cAAEA53A9aAF570D` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0xf2Ef32Ad92E86905d26a8488cAAEA53A9aAF570D))

## Environment Variables

```env
NEXT_PUBLIC_CHAIN_ID=11155111
NEXT_PUBLIC_RPC_URL=https://sepolia.gateway.tenderly.co
NEXT_PUBLIC_RELAYER_URL=https://relayer.testnet.zama.org
NEXT_PUBLIC_ENERGY_MARKET_ADDRESS=0xFc86a29F5E80728a2E5226Cb2850A5ddf9150dD6
NEXT_PUBLIC_PRODUCTION_TRACKER_ADDRESS=0xE026756cBf5DAA4ef116a9DD4A858d93540A77F8
NEXT_PUBLIC_CONSUMPTION_MANAGER_ADDRESS=0xf2Ef32Ad92E86905d26a8488cAAEA53A9aAF570D
```

## Deployment

1. Deploy smart contracts to Sepolia
2. Update `contracts.json` with deployed addresses
3. Configure environment variables
4. Deploy frontend to Vercel

## API Functions

**EnergyMarket:**
- `createEnergyOffer(euint32 encryptedVolume, euint32 encryptedPrice)` - Create energy offer
- `purchaseEnergy(uint256 offerId, euint32 encryptedAmount)` - Purchase energy
- `settleTrade(uint256 tradeId)` - Settle energy trade

**ProductionTracker:**
- `recordProduction(euint32 encryptedAmount, uint256 timestamp)` - Record energy production
- `getTotalProduction(address producer)` - Get total production (encrypted)

**ConsumptionManager:**
- `recordConsumption(euint32 encryptedAmount, uint256 timestamp)` - Record energy consumption
- `getTotalConsumption(address consumer)` - Get total consumption (encrypted)

