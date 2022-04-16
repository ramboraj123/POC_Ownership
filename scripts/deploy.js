async function main() {
    const Ownership = await ethers.getContractFactory("Ownership")
  
    // Start deployment, returning a promise that resolves to a contract object
    const ownership = await Ownership.deploy()
    await ownership.deployed()
    console.log("Contract deployed to address:", ownership.address)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
  