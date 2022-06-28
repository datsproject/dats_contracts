const { ethers } = require('hardhat');

async function main() {
    // Get the signer (provider)
    const [deployer] = await ethers.getSigners();

    const DatsContract = await ethers.getContractFactory('DatsContract');
    const datsContract = await DatsContract.deploy();

    console.log("Contract address: ", datsContract.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });