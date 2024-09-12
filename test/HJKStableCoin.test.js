const HJKStableCoin = artifacts.require("HJKStableCoin");

contract("HJK Stablecoin", (accounts) => {
  let tokenStablecoin;

  const [owner, recipient] = accounts;

  beforeEach(async () => {
    tokenStablecoin = await HJKStableCoin.deployed();
  });
});
