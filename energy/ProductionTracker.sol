// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract ProductionTracker is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct ProductionRecord {
        address producer;
        euint32 amount; // Encrypted amount in kWh
        uint256 timestamp;
    }
    
    mapping(address => ProductionRecord[]) public producerRecords;
    mapping(address => euint32) public totalProduction; // Encrypted total
    
    // Record energy production
    function recordProduction(
        euint32 encryptedAmount,
        uint256 timestamp
    ) external returns (uint256 recordId) {
        ProductionRecord memory record = ProductionRecord({
            producer: msg.sender,
            amount: encryptedAmount,
            timestamp: timestamp > 0 ? timestamp : block.timestamp
        });
        
        producerRecords[msg.sender].push(record);
        totalProduction[msg.sender] = totalProduction[msg.sender].add(encryptedAmount);
        
        recordId = producerRecords[msg.sender].length - 1;
        emit ProductionRecorded(msg.sender, recordId, encryptedAmount, record.timestamp);
    }
    
    // Get total production (encrypted)
    function getTotalProduction(address producer) external view returns (euint32) {
        return totalProduction[producer];
    }
    
    // Get production record count
    function getRecordCount(address producer) external view returns (uint256) {
        return producerRecords[producer].length;
    }
    
    // Make production decryptable
    function makeProductionDecryptable(address producer) external {
        require(msg.sender == producer, "Not producer");
        FHE.makePubliclyDecryptable(totalProduction[producer]);
        emit ProductionMadeDecryptable(producer);
    }
    
    event ProductionRecorded(address indexed producer, uint256 indexed recordId, euint32 amount, uint256 timestamp);
    event ProductionMadeDecryptable(address indexed producer);
}

