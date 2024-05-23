const HelloBlockchain = artifacts.require("./HelloBlockchain.sol");
// const sepoliaProviderUrl = `https://sepolia.infura.io/v3/${infuraApiKey}`;  
// const sepoliaProvider = new ethers.providers.JsonRpcProvider(sepoliaProviderUrl);

// const uniswapRouterAddress = '0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008';
// const uniswapRouterContract = new ethers.Contract( uniswapRouterAddress, uniswapRouterAbi, sepoliaProvider );
contract("HelloBlockchain", accounts => {
  it("...should store the value 'Hello Blockchain'.", async () => {
    const helloBlockchainInstance = await HelloBlockchain.deployed();

    // Set value of Hello World
    await helloBlockchainInstance.SendRequest("Hello Blockchain", { from: accounts[0] });

    // Get stored value
    const storedData = await helloBlockchainInstance.RequestMessage.call();

    assert.equal(storedData, "Hello Blockchain", "The value 'Hello Blockchain' was not stored.");
  });
});
