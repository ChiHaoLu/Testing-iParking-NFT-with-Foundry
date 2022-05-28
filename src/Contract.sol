// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract CarMan is ERC721Enumerable, Ownable {
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  string public notRevealedUri;
  uint256 public cost = 0.5 ether;
  uint256 public maxSupply = 2000;
  uint256 public maxMintAmount = 10;
  uint256 public nftPerAddressLimit = 10;
  uint256 public currentPhaseMintMaxAmount = 110;

  uint32 public publicSaleStart = 1647136800;
  uint32 public preSaleStart = 1646964000;
  uint32 public vipSaleStart = 1646618400;

  bool public publicSalePaused = true;
  bool public preSalePaused = true;
  bool public vipSalePaused = true;
  
  bool public revealed = false;
  bool public onlyWhitelisted = true;
  address[] whitelistedAddresses;

  mapping(address => uint256) addressMintedBalance;
  mapping(address => uint256) vipMintAmount;

  // addresses to manage this contract
  mapping(address => bool) controllers;


  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol) {
    baseURI = _initBaseURI;
    notRevealedUri = _initNotRevealedUri;
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public
  function vipSaleMint(uint256 _mintAmount) public {
    require(_mintAmount > 0, "Mint Amount should be bigger than 0");
    require((!vipSalePaused)&&(vipSaleStart <= block.timestamp), "Not Reach VIP Sale Time");
  
    uint256 supply = totalSupply();
    require(_mintAmount > 0, "need to mint at least 1 NFT");
    require(_mintAmount <= maxMintAmount, "max mint amount per session exceeded");
    require(supply + _mintAmount <= currentPhaseMintMaxAmount, "reach current Phase NFT limit");
    require(supply + _mintAmount <= maxSupply, "max NFT limit exceeded");

    require(vipMintAmount[msg.sender] != 0, "user is not VIP");
    uint256 ownerMintedCount = addressMintedBalance[msg.sender];
    uint256 vipMintCount = vipMintAmount[msg.sender];
 
    require(ownerMintedCount + _mintAmount <= vipMintCount, "max VIP Mint Amount exceeded");
    require(ownerMintedCount + _mintAmount <= nftPerAddressLimit, "max NFT per address exceeded");
    
    for (uint256 i = 1; i <= _mintAmount; i++) {
        addressMintedBalance[msg.sender]++;
      _safeMint(msg.sender, supply + i);
    }
  }

  function preSaleMint(uint256 _mintAmount) public payable {
    require(_mintAmount > 0, "Mint Amount should be bigger than 0");
    require((!preSalePaused)&&(preSaleStart <= block.timestamp), "Not Reach Pre Sale Time");
  
    uint256 supply = totalSupply();
    require(_mintAmount > 0, "need to mint at least 1 NFT");
    require(_mintAmount <= maxMintAmount, "max mint amount per session exceeded");
    require(supply + _mintAmount <= currentPhaseMintMaxAmount, "reach current Phase NFT limit");
    require(supply + _mintAmount <= maxSupply, "max NFT limit exceeded");

    if (msg.sender != owner()) {
        if(onlyWhitelisted == true) {
            require(isWhitelisted(msg.sender), "user is not whitelisted");
            uint256 ownerMintedCount = addressMintedBalance[msg.sender];
            require(ownerMintedCount + _mintAmount <= nftPerAddressLimit, "max NFT per address exceeded");
        }
        require(msg.value >= cost * _mintAmount, "insufficient funds");
    }
    
    for (uint256 i = 1; i <= _mintAmount; i++) {
        addressMintedBalance[msg.sender]++;
      _safeMint(msg.sender, supply + i);
    }
  }

  function publicSaleMint(uint256 _mintAmount) public payable {
    require(_mintAmount > 0, "Mint Amount should be bigger than 0");
    require((!publicSalePaused)&&(publicSaleStart <= block.timestamp), "Not Reach Public Sale Time");
  
    uint256 supply = totalSupply();
    require(_mintAmount > 0, "need to mint at least 1 NFT");
    require(_mintAmount <= maxMintAmount, "max mint amount per session exceeded");
    require(supply + _mintAmount <= currentPhaseMintMaxAmount, "reach current Phase NFT limit");
    require(supply + _mintAmount <= maxSupply, "max NFT limit exceeded");

    if (msg.sender != owner()) {
        if(onlyWhitelisted == true) {
            require(isWhitelisted(msg.sender), "user is not whitelisted");
            uint256 ownerMintedCount = addressMintedBalance[msg.sender];
            require(ownerMintedCount + _mintAmount <= nftPerAddressLimit, "max NFT per address exceeded");
        }
        require(msg.value >= cost * _mintAmount, "insufficient funds");
    }
    
    for (uint256 i = 1; i <= _mintAmount; i++) {
        addressMintedBalance[msg.sender]++;
      _safeMint(msg.sender, supply + i);
    }
  }
  
  function isWhitelisted(address _user) public view returns (bool) {
    for (uint i = 0; i < whitelistedAddresses.length; i++) {
      if (whitelistedAddresses[i] == _user) {
          return true;
      }
    }
    return false;
  }

  function walletOfOwner(address _owner) public view returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    if(revealed == false) {
        return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

  function publicSaleIsActive() public view returns (bool) {
    return ( (publicSaleStart <= block.timestamp) && (!publicSalePaused) );
  }

  function preSaleIsActive() public view returns (bool) {
    return ( (preSaleStart <= block.timestamp) && (!preSalePaused) );
  }

  function vipSaleIsActive() public view returns (bool) {
    return ( (vipSaleStart <= block.timestamp) && (!vipSalePaused) );
  }

  function checkVIPMintAmount(address _account) public view returns (uint256) {
    return vipMintAmount[_account];
  }

  // for controller
  function reveal(bool _state) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    revealed = _state;
  }
  
  function setNftPerAddressLimit(uint256 _limit) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    nftPerAddressLimit = _limit;
  }
  
  function setCost(uint256 _newCost) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    cost = _newCost;
  }

  function setmaxMintAmount(uint256 _newmaxMintAmount) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    maxMintAmount = _newmaxMintAmount;
  }

  function setcurrentPhaseMintMaxAmount(uint256 _newPhaseAmount) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    currentPhaseMintMaxAmount = _newPhaseAmount;
  }

  function setPublicSaleStart(uint32 timestamp) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    publicSaleStart = timestamp;
  }
  
  function setPreSaleStart(uint32 timestamp) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    preSaleStart = timestamp;
  } 

  function setVIPSaleStart(uint32 timestamp) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    vipSaleStart = timestamp;
  }

  function setBaseURI(string memory _newBaseURI) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    baseExtension = _newBaseExtension;
  }
  
  function setNotRevealedURI(string memory _notRevealedURI) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    notRevealedUri = _notRevealedURI;
  }

  function setPreSalePause(bool _state) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    preSalePaused = _state;
  }

  function setVIPSalePause(bool _state) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    vipSalePaused = _state;
  }

  function setVIPMintAmount(address[] memory _accounts, uint256[] memory _amounts) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    require(_accounts.length == _amounts.length, "accounts and amounts array length mismatch");

    for (uint256 i = 0; i < _accounts.length; ++i) {
      vipMintAmount[_accounts[i]]=_amounts[i];
    }
  }

  function setPublicSalePause(bool _state) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    publicSalePaused = _state;
  }
  
  function setOnlyWhitelisted(bool _state) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    onlyWhitelisted = _state;
  }
  
  function whitelistUsers(address[] calldata _users) public {
    require(controllers[msg.sender], "Only controllers can operate this function");
    delete whitelistedAddresses;
    whitelistedAddresses = _users;
  }

  //only owner
 
   /**
   * enables an address for management
   * @param controller the address to enable
   */
  function addController(address controller) external onlyOwner {
    controllers[controller] = true;
  }

  /**
   * disables an address for management
   * @param controller the address to disbale
   */
  function removeController(address controller) external onlyOwner {
    controllers[controller] = false;
  }
 
  function withdraw() public onlyOwner {
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }
}