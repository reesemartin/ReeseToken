import { ethers } from "hardhat";

async function main() {
  // We get the contract to deploy
  const ReeseToken = await ethers.getContractFactory("ReeseToken");
  const reeseTokenContract = await ReeseToken.deploy("Hello, Hardhat!");

  await reeseTokenContract.deployed();

  console.log("ReeseToken deployed");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
