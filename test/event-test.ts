import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Event contract", function () {
  
  let owner: SignerWithAddress;
  let addr1: SignerWithAddress;
  let addr2: SignerWithAddress;

  this.beforeEach(async function () {

    [owner, addr1, addr2] = await ethers.getSigners();

    const EventFactory = await hre.ethers.getContractFactory("Event");
    const event = await EventFactory.deploy(addr2.getAddress());
    await event.deployed();

  });

  it("Should deploy Event contract and set the Token address", async function () {

    const EventFactory = await hre.ethers.getContractFactory("Event");
    const event = await EventFactory.deploy(addr2.getAddress());
    await event.deployed();

    expect(await event.ticketContract()).to.equal(await addr2.getAddress());
  });

  it("Should create an event", async function () {

    const EventFactory = await hre.ethers.getContractFactory("Event");
    const event = await EventFactory.deploy(addr2.getAddress());
    await event.deployed();

    expect(await event.getEventCount()).to.equal(0);
    await expect(event.createNewEvent("test-event", 10, 10))
      .to.emit(event, "NewEvent")
      .withArgs(0, await owner.getAddress());
    expect(await event.getEventCount()).to.equal(1);
    expect((await event.events(0)).name).to.equal("test-event");

  });
});
