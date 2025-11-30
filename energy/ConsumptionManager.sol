// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract ConsumptionManager is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct ConsumptionRecord {
        address consumer;
        euint32 amount; // Encrypted amount in kWh
        uint256 timestamp;
    }
    
    mapping(address => ConsumptionRecord[]) public consumerRecords;
    mapping(address => euint32) public totalConsumption; // Encrypted total
    
    // Record energy consumption
    function recordConsumption(
        euint32 encryptedAmount,
        uint256 timestamp
    ) external returns (uint256 recordId) {
        ConsumptionRecord memory record = ConsumptionRecord({
            consumer: msg.sender,
            amount: encryptedAmount,
            timestamp: timestamp > 0 ? timestamp : block.timestamp
        });
        
        consumerRecords[msg.sender].push(record);
        totalConsumption[msg.sender] = totalConsumption[msg.sender].add(encryptedAmount);
        
        recordId = consumerRecords[msg.sender].length - 1;
        emit ConsumptionRecorded(msg.sender, recordId, encryptedAmount, record.timestamp);
    }
    
    // Get total consumption (encrypted)
    function getTotalConsumption(address consumer) external view returns (euint32) {
        return totalConsumption[consumer];
    }
    
    // Get consumption record count
    function getRecordCount(address consumer) external view returns (uint256) {
        return consumerRecords[consumer].length;
    }
    
    // Make consumption decryptable
    function makeConsumptionDecryptable(address consumer) external {
        require(msg.sender == consumer, "Not consumer");
        FHE.makePubliclyDecryptable(totalConsumption[consumer]);
        emit ConsumptionMadeDecryptable(consumer);
    }
    
    event ConsumptionRecorded(address indexed consumer, uint256 indexed recordId, euint32 amount, uint256 timestamp);
    event ConsumptionMadeDecryptable(address indexed consumer);
}

