const HJKStableCoin = artifacts.require("HJKStableCoin");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(HJKStableCoin, accounts[0]);

  console.log(`Address contract is ${HJKStableCoin.address}`);
};
