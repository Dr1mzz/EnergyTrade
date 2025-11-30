import { ethers } from "hardhat";
import * as dotenv from "dotenv";

dotenv.config();

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts...");
  const balance = await ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", ethers.formatEther(balance), "ETH");

  // Deploy EnergyMarket
  console.log("\nDeploying EnergyMarket...");
  const EnergyMarket = await ethers.getContractFactory("EnergyMarket");
  const energyMarket = await EnergyMarket.deploy();
  await energyMarket.waitForDeployment();
  const energyMarketAddress = await energyMarket.getAddress();
  console.log("EnergyMarket deployed to:", energyMarketAddress);

  // Deploy ProductionTracker
  console.log("\nDeploying ProductionTracker...");
  const ProductionTracker = await ethers.getContractFactory("ProductionTracker");
  const productionTracker = await ProductionTracker.deploy();
  await productionTracker.waitForDeployment();
  const productionTrackerAddress = await productionTracker.getAddress();
  console.log("ProductionTracker deployed to:", productionTrackerAddress);

  // Deploy ConsumptionManager
  console.log("\nDeploying ConsumptionManager...");
  const ConsumptionManager = await ethers.getContractFactory("ConsumptionManager");
  const consumptionManager = await ConsumptionManager.deploy();
  await consumptionManager.waitForDeployment();
  const consumptionManagerAddress = await consumptionManager.getAddress();
  console.log("ConsumptionManager deployed to:", consumptionManagerAddress);

  // Summary
  console.log("\n" + "=".repeat(60));
  console.log("Deployment Summary");
  console.log("=".repeat(60));
  console.log("ENERGY_MARKET:", energyMarketAddress);
  console.log("PRODUCTION_TRACKER:", productionTrackerAddress);
  console.log("CONSUMPTION_MANAGER:", consumptionManagerAddress);
  console.log("=".repeat(60));

  // Save addresses to .env format
  console.log("\nAdd these to your .env file:");
  console.log(`ENERGY_MARKET_ADDRESS=${energyMarketAddress}`);
  console.log(`PRODUCTION_TRACKER_ADDRESS=${productionTrackerAddress}`);
  console.log(`CONSUMPTION_MANAGER_ADDRESS=${consumptionManagerAddress}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

