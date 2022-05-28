// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import '../Contract.sol';

interface CheatCodes {
  function prank(address) external;
}

contract CarManTest is DSTest {
  CarMan carman;
  CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
  address DEPLOYER_ADDRESS;
  address[] public temp;
  
  // The state of the contract gets reset before each
  // test is run, with the `setUp()` function being called
  // each time after deployment. Think of this like a JavaScript
  // `beforeEach` block
  function setUp() public {
    carman = new CarMan("CarMan_Metaverse", "CMM", "ipfs://QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/", "ipfs://.../");
    DEPLOYER_ADDRESS = carman.owner();
    carman.addController(DEPLOYER_ADDRESS); // deployer can addController
    carman.setPreSalePause(false); // deployer/controller can setPreSalePause
    for(uint i = 0; i < 800; i++){
      address randomish = address(uint160(uint(keccak256(abi.encodePacked(i, blockhash(block.number))))));
      temp.push(randomish);
    }
    temp.push(DEPLOYER_ADDRESS);
    carman.whitelistUsers(temp);
  }

  function onERC721Received(
      address, 
      address, 
      uint256, 
      bytes calldata
  )external pure returns(bytes4) {
      return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
  } 
  /*
  _checkOnERC721Received has the verification logic. If to address is a contract, 
  then the contract should implement onERC721Received interface of ERC-721 and return correct 4 bytes hash to receive ERC-721 token as below. 
  solved reference: https://docs.klaytn.com/smart-contract/sample-contracts/erc-721/1-erc721#3-safetransferfrom-and-transferfrom
  */

  function testDeployerCanMint(uint x) public {
    assertEq(carman.totalSupply(), 0); // nothing minted before
    if(x > carman.maxMintAmount()){
      carman.preSaleMint(10);
      assertEq(carman.totalSupply(), carman.maxMintAmount());
    }
    else if(x > 0){
      carman.preSaleMint(x);
      assertEq(carman.totalSupply(), x);
    }
  }

  function testFailNotWLMint() public {
    cheats.prank(address(0));
    carman.preSaleMint(10);
  }
}