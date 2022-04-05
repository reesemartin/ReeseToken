import { expect } from "chai";
import { ethers } from "hardhat";

describe("ReeseToken", function () {
  it("Should deploy", async function () {
    const ReeseToken = await ethers.getContractFactory("ReeseToken");
    const reeseTokenContract = await ReeseToken.deploy(1000000000);
    await reeseTokenContract.deployed();
  });
});
