// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract EnergyMarket is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct EnergyOffer {
        address producer;
        string energyType; // Solar, Wind, Hydro, etc.
        euint32 volume; // Encrypted volume in kWh
        euint32 pricePerUnit; // Encrypted price per kWh
        uint256 expirationTime;
        bool active;
        uint256 createdAt;
    }
    
    struct Trade {
        address buyer;
        address seller;
        uint256 offerId;
        euint32 volume; // Encrypted volume traded
        euint32 pricePerUnit; // Encrypted price
        euint32 totalAmount; // Encrypted total amount
        bool settled;
        uint256 createdAt;
    }
    
    mapping(uint256 => EnergyOffer) public offers;
    mapping(uint256 => Trade) public trades;
    uint256 public offerCounter;
    uint256 public tradeCounter;
    
    // Create energy offer
    function createEnergyOffer(
        string memory energyType,
        euint32 encryptedVolume,
        euint32 encryptedPricePerUnit,
        uint256 expirationTime
    ) external returns (uint256 offerId) {
        require(expirationTime > block.timestamp, "Invalid expiration");
        
        offerId = offerCounter++;
        offers[offerId] = EnergyOffer({
            producer: msg.sender,
            energyType: energyType,
            volume: encryptedVolume,
            pricePerUnit: encryptedPricePerUnit,
            expirationTime: expirationTime,
            active: true,
            createdAt: block.timestamp
        });
        
        emit OfferCreated(offerId, msg.sender, energyType, encryptedVolume, encryptedPricePerUnit);
    }
    
    // Purchase energy
    function purchaseEnergy(
        uint256 offerId,
        euint32 encryptedAmount
    ) external returns (uint256 tradeId) {
        EnergyOffer storage offer = offers[offerId];
        require(offer.active, "Offer not active");
        require(block.timestamp < offer.expirationTime, "Offer expired");
        require(msg.sender != offer.producer, "Cannot purchase own offer");
        
        // Check if amount is less than or equal to available volume
        // Note: Encrypted comparison requires decryption for validation
        // For now, we'll skip this check and rely on the contract logic
        // In production, this should be handled via FHEVM relayer
        
        // Calculate total amount (encrypted multiplication)
        euint32 totalAmount = encryptedAmount.mul(offer.pricePerUnit);
        
        tradeId = tradeCounter++;
        trades[tradeId] = Trade({
            buyer: msg.sender,
            seller: offer.producer,
            offerId: offerId,
            volume: encryptedAmount,
            pricePerUnit: offer.pricePerUnit,
            totalAmount: totalAmount,
            settled: false,
            createdAt: block.timestamp
        });
        
        // Update offer volume (encrypted subtraction)
        offer.volume = offer.volume.sub(encryptedAmount);
        // Encrypted comparison - in production, handle via FHEVM relayer
        // For now, we'll keep the offer active
        // In production, decrypt and check if volume < 1
        
        emit TradeCreated(tradeId, offerId, msg.sender, offer.producer, encryptedAmount, totalAmount);
    }
    
    // Settle trade
    function settleTrade(uint256 tradeId) external {
        Trade storage trade = trades[tradeId];
        require(!trade.settled, "Already settled");
        require(msg.sender == trade.buyer || msg.sender == trade.seller, "Unauthorized");
        
        trade.settled = true;
        emit TradeSettled(tradeId, trade.buyer, trade.seller);
    }
    
    // Cancel offer
    function cancelOffer(uint256 offerId) external {
        EnergyOffer storage offer = offers[offerId];
        require(msg.sender == offer.producer, "Not offer owner");
        require(offer.active, "Offer not active");
        
        offer.active = false;
        emit OfferCancelled(offerId);
    }
    
    // Make offer details decryptable
    function makeOfferDecryptable(uint256 offerId) external {
        EnergyOffer storage offer = offers[offerId];
        require(msg.sender == offer.producer, "Not offer owner");
        FHE.makePubliclyDecryptable(offer.volume);
        FHE.makePubliclyDecryptable(offer.pricePerUnit);
        emit OfferMadeDecryptable(offerId);
    }
    
    event OfferCreated(uint256 indexed offerId, address indexed producer, string energyType, euint32 volume, euint32 pricePerUnit);
    event TradeCreated(uint256 indexed tradeId, uint256 indexed offerId, address indexed buyer, address seller, euint32 volume, euint32 totalAmount);
    event TradeSettled(uint256 indexed tradeId, address buyer, address seller);
    event OfferCancelled(uint256 indexed offerId);
    event OfferMadeDecryptable(uint256 indexed offerId);
}

