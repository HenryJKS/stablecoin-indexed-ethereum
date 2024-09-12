const HJKStableCoin = artifacts.require("HJKStableCoin");

contract("HJK Stablecoin", (accounts) => {
  let tokenStablecoin;

  const [owner] = accounts;

  beforeEach(async () => {
    tokenStablecoin = await HJKStableCoin.deployed();
  });

  it("symbol name", async() => {
    let symbol = await tokenStablecoin.symbol();
    
    assert.equal(symbol, 'HSC');
  });
});
