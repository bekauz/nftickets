const hre = require("hardhat");

async function main() {

  const EventFactory = await hre.ethers.getContractFactory("Event");
  const event = await EventFactory.deploy();

  await event.deployed();

  console.log("Event contract deployed to:", event.address);
  await event.createNewEvent("whatever", 10, 10);
  
  console.log(await event.events(0));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
