# Testing-iParking-NFT-with-Foundry
[How To Test The Smart Contract Of iParking NFT With Foundry](https://medium.com/@ChiHaoLu/how-to-test-the-smart-contract-of-iparking-nft-with-foundry-bc8bdbe6a359)

---

# How To Test The Smart Contract Of iParking NFT With Foundry 

---

###### tags: `TOPIC`
:::warning
â ï¸ **Of course this is only my personal thoughts, don't be too serious haha...** â ï¸
:::
**Final Updated: 2022/3/17**

---

## ð Table of Contents

* Intro. of the event
* Cast an eye over the contract
* What is Foundry!?
* Testing Time
* Conclusion
* Reference

### Synchronization Link Tree

* [HackMD](https://hackmd.io/@ChiHaoLu/iParking-Foundry-Testing)
* [Medium](https://)
* [LinkedIn](https://www.linkedin.com/in/ChiHaoLu/)
* [Github](https://github.com/ChiHaoLu)

---

## ð¿ Intro.

### iParking NFT & What happened?

ç°¡å®ä¾èªªæå°äºä»¶çèµ·å åéç¨ä¹ä¸æ¯æèä»éº¼æ·±åº¦çäºè§£ï¼ä¸»è¦æ¥æ¶è³è¨çä¾æºä¹å°±æ¯ä»¥ä¸å©èï¼å¨ééæå°±éä¸é£çµè®å¤§å®¶èªè¡åèäºï¼

* [ååæ¿ NFT ç½åå®åºåï¼ç¶²çæãè±ä¸ç¾ç¾åæçºè²»éå¤±æãï¼å®æ¹åæï¼Gas Limit è¨­å¤ªä½](https://www.blocktempo.com/iparking-nft-mint-failed-due-to-low-gas-limit/)
* [ååæ¿NFTåºåäºä»¶æ¶äººå - FulyAI Founder Rex Chen](https://medium.com/fuly-ai-%E6%99%BA%E8%83%BD%E6%8A%95%E8%B3%87%E7%AD%96%E7%95%A5%E6%A9%9F%E5%99%A8%E4%BA%BA-bitfinex-%E6%94%BE%E8%B2%B8%E6%A9%9F%E5%99%A8%E4%BA%BA/%E5%98%9F%E5%98%9F%E6%88%BFnft%E5%87%BA%E5%8C%85%E4%BA%8B%E4%BB%B6%E6%87%B6%E4%BA%BA%E5%8C%85-4a4acd7fe0c2)

### Motivation

æç¼ç¾å¥½åæ²æçå°äººé¸æä»¥å¨åç´é¨å±¬ãåãæé²è¡ãæ¸¬è©¦ãçè§åº¦ä¾çéæ¬¡çäºä»¶ï¼èæ¯å¨é¯èª¤ç¼çãå¾ãç¨ãèç¼ãè§å¯åç´ä¾æ¾å°åé¡å¨åªãè¬éäºä¸¦ä¸æ¯è¦èªªä»»ä½è©è«éä»¶äºæçå¥½åè¼©åå¥½å¤¥ä¼´åçä¸æ¯ï¼çæ­£é¯çä¹å°±åªæéç¼åéï¼éææ²æåå¥½äºå¾èçç MOD èå·²ã

åºç¶éæ¬¡çé¯èª¤æ¯èç¼æ¸æ°å¯è¦çï¼èä¸æ°´æ±ªæ±ªçå¤§ç¼çåå¤§è¦æäºæåç¢ºå¯¦æ¯æ¯ææç¨å¼ç¢¼å¥½ç¨è¨±å¤çååååã

ä¸é Testing æ¯æèªçºæçºä¸åè·æ¥­å·¥ç¨å¸«ä¸åå¾éè¦çæª»ï¼æèªèªçºè·é¢ä¸åçæ­£çå·¥ç¨å¸«éæä¸å°çè·é¢ï¼æä»¥æ³è¦èæ­¤æ©æä¾ç·´ç¿ä¸ä¸ç¨ä¹åé³åå¤§å¤§åè¨´æç Foundry æ°å¯«æ¸¬è©¦ï¼

éç¯æç« çä¸»è»¸å¶å¯¦éæ¯æèªå·±å­¸ç¿ Foundry çå°å°ç­è¨ï¼ååæ¿åªæ¯ä¸åæ´»ä¾èå·² :D

é£å¨éå§ä¹åï¼ååå°æ´åæç« æä¸éå§çå®£åï¼

:::warning
â ï¸ **Of course this is only my personal thoughts, don't be too serious haha...** â ï¸
:::

> å¤§å®¶å¦æç¼ç¾æä¸­çä»»ä½é¯èª¤ææä»»ä½æ³æ³ï¼è«ä¸åãå¤§æ¹å°åè¨´æï¼å çºéå¨å­¸ç¿ä¸­ï¼ææç¡æ¢ä»¶æ¥åæææè¦åæ³æ³çï¼

---

## ð Cast an eye over the contract

ç¾å¨æååèä¸è¿°åè¼©ååªé«çè³æï¼å¤§æ¦çå¯ä»¥åææè¡å±¤é¢çåé¡å®ä½å¨ï¼
1. ä½¿ç¨ `array` éåè³æçµæ§ä¾å¯¦ä½ç½åå®ç³»çµ±
2. Gas Limit çè¨­å®åé¡

é£æ¯æåä¾çç¨å¼ç¢¼å¦ï¼

[iParking NFT Source Code in Etherscan.io](https://etherscan.io/address/0xae122962331c2b02f837b2aa501d3c5d903ed28a#code)

### The path of the Contract Inheritance

ééåºæ¬ä¸ææ¯é éå»çï¼æçååæ¿çå·¥ç¨å¸«æè©²ï¼æè©²ï¼æè©²æ²æç¹å¥å»æ¹éäºç¹¼æ¿èä¾çåç´å§å®¹å§ï¼å¦ææçè©±æåéæ­><

``` mermaid
%%{init: {'theme': 'forest' } }%%
graph TD;
    library-{Strings, Address}
    interface-IERC721Receiver-->ERC721
    IERC165-->IERC721;
    IERC721-->IERC721Enumerable;
    IERC165-->ERC165;
    IERC721-->IERC721Metadata;
    IERC721Metadata-->ERC721;
    IERC721-->ERC721;
    ERC165-->ERC721;
    Context-->ERC721;
    IERC721Enumerable-->ERC721Enumerable;
    ERC721-->ERC721Enumerable;
    Context--->Ownable;
    ERC721Enumerable-->CarMan;
    Ownable-->CarMan;
```

ä½å¶å¯¦ OpenZeppelin è£¡é¢æè¨±å¤ç¨ä¸å°çæ±è¥¿ï¼è®æ¸ãè³æçµæ§ãå®£åç­ï¼å¯ä»¥åªæï¼è½èæ­¤ä¾æ Gas Fee éä½ãæä»¥æèªå·±å¨å¯« Project çæåé½æç¿æ£ä¸è¦ç´æ¥ç¹¼æ¿ Github ä¸é¢çå§å®¹ï¼èæ¯æéè¦çæ±è¥¿è²¼éä¾ä¸åä¸åæ¹ææ³è¦çæ¨£å­ã

OpenZeppelin çå®å¨æ§åä¾¿å©æ§æ¯è¨±å¤äººæç¨±è¨±çï¼å¯å°æåéäºç§å­¸å®¶/å·¥ç¨å¸«ï¼åæéç¨®èéå¯è½æ¯ååï¼ä¾èªªï¼ç´°ç´°çæéä¸ä¸æåè¦ä½¿ç¨çæ±è¥¿ä¹è »éè¦çå°å§ï¼

å¦æèªå·±é¨ä¾¿äºæ¹ç¶å¾åç´åèåºç¾ Bugï¼é£ç¢ºå¯¦æ¯æ¿ç³é ­ç ¸èªå·±è³ãæå°±å¾å¸¸éæ¨£ï¼åå...

> ä¸éç¢ç«å·¥ä½æ¯ææ¶èªæ°´çï¼ä¸ç®¡æ¯ç¹¼æ¿å½å¼åº«éæ¯å¼å« API é½å¾è¦æ´å°å¿ãé¨èæèªå·±æ´æ·±å¥å°äºè§£ééæè¡ï¼æç¼ç¾å¾å¤æåç¨å¼ç¢¼ä¸æ¯åªæ Copy-Paste é£éº¼ç°¡å®ã

### CarMan

é£æåå°±ç´æ¥çå°ç¹¼æ¿äºæ­·ä»£åç¥åçåçéºç¢ï¼æºåè¿ä¾äººçæåçæå¾ä¸»åç´å§ï¼

æä¸¦ä¸æéå¸¸ä»ç´°çä¸ä¸è¬è§£åç´è£¡é¢çæ¯åè®æ¸ãå½å¼çç´°ç¯ï¼ééå°±æ¯å»å¤§æ¦æ¸åºåç´è£¡é¢æä»éº¼æ±è¥¿èå·²ãé£å¸æå¤§å®¶é¨èææä¸­çå¼ç¨ç¨å¼ç¢¼ä¸èµ·ä¾ççè£¡é¢å°åºé½å¯«äºä»éº¼å§ï¼

æéå§é½æ¯å®£åçæ¬ãå®£ååç´ä»¥åç¹¼æ¿ï¼é²å°åç´ä¹å¾åå®£åäºä¸äºå¸¸æ¸ï¼
```solidity=
pragma solidity >=0.7.0 <0.9.0;

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
```

é¦¬ä¸å°±éå°ç¬¬ä¸åè¢«å¤§å®¶æ¿åºä¾é­çå°å¤¥ä¼´ï¼`array` åæç `whitelistedAddresses`ï¼
```solidity=
  bool public revealed = false;
  bool public onlyWhitelisted = true;
  address[] whitelistedAddresses;

  mapping(address => uint256) addressMintedBalance;
  mapping(address => uint256) vipMintAmount;

  // addresses to manage this contract
  mapping(address => bool) controllers;
```
 
è² è²¬æ¥æ¶åå§ååæ¸åçå»ºæ§å­ï¼éææå° NFT Metadata ç `baseURI`ï¼å¦ææ¯å­å¨ IPFS çè©±é£å°±æ¯ä»ç CIDï¼
```solidity=
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
```

çµ¦ VIP å `mint` çå½å¼ï¼
```solidity=
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

```

é å®ç¨ç `mint` å½å¼ï¼
```solidity=
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
```

å¬å®ç¨ç `mint` å½å¼ï¼
```solidity=
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
```

å¤æ·ç¶åè¨æ¯å³éèï¼å¦ææ¯äº¤ææè `mint` é£ `msg.sender` èªç¶æ¯æ¶è²»èï¼æ¯å¦çºç½åå®æå¡ï¼
```solidity=
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
```

æ­£å¸¸ç NFT åç´æç `tokenURI`ï¼
```solidity=
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
```

éæ¼ä¸äºéé å½å¼çåå & ééæ¢ä»¶ã
```solidity=
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
```

æ¯ä¸äºææç®¡çæ¬çäººåæè½å¼å«çå½å¼ãéå¸¸éç¨®å½å¼è¶å¤æè¦ºå¾å°±è¶ä¸­å¿åï¼ä¸éæ¢ç¶ä¸åé½æ¯éæä¸æ¸æ¥æç½çå¯«å¨ç¨å¼ç¢¼ä¸ï¼å¶å¯¦ sign äºå°±ä»£è¡¨æååææ¥åéååç´å°å§ï¼
```solidity=
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
```

æ§å¶æ¬ï¼å¨éååç´è£¡é¢ä¹ç®æ¯ç®¡çæ¬çäººå¡ç®¡çå½å¼ï¼
```solidity=
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
```

è³ºäºé¢è¨å¾è¦æé¢æ¿åºä¾ç `withdraw` å½å¼ï¼
```solidity=
  function withdraw() public onlyOwner {
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }
}
```

---

## ð What is Foundry!?

### Unit Testing of Smart Contract

éå¾æåå¨é²è¡ Testing çæåç¡éæ¯ä½¿ç¨ Hardhat, Truffle, DappTools ç­æ°å¯« Javascript/ Typescript èªæ³çæ¸¬è©¦ï¼æå¾æ­é Ganache, Infura ç­ä¾æç¨ãå¶ä»è¥ç©éæåå« ethers.js, mocha, waffle, chai ä¹é¡ç blablablaï¼å¤§å®¶èªè¡é«æ :D

ä½æå¯«éçäººå¯è½é½ç¥éï¼å¨æåç node_modules è£¡é¢æè©²åæ»¿äºåå¼åæ¨£ç dependenciesï¼åä»»ä½éç¼ä¹åé½è¦åä¾ä¸å¥åªå¥ä»¶ãéè¼å¥ä»¶ãéçæ¬ãç°å¢è®æ¸ä¹é¡ççµåæ³ï¼ä¹ç®æ¯å¤ æ±äººç...

éç¶ Javascript å·²ç¶æ¯ä¸åäººæä¸æçå©å¨ï¼ä½èº«çºä¸åæ°å¯« Solidity çå·¥ç¨å¸«æ¸¬è©¦å»è¦ç¨å¦å¤ä¸åèªè¨ä¾å¯«ï¼ç¸½æ¯æè¦ºå¾åªè£¡æªæªçï¼åï¼ãæ´ä¸ç¨èªª Big Number éåå¥ä»¶æäºæåéæé æä¸äºåé¡ã

ä¸éç¾å¨è½å¤ ç¨ Solidity ä¸åæå¤©ä¸çç«èåºç¾äºï¼é£å°±æ¯ææå¿«ç æºç Foundryï¼ï¼æè²æ­¡è¿ððï¼

### Introduction

[**Foundry**](https://github.com/gakonst/foundry) æ¯ä¸åä½¿ç¨ Rust å»ºç½®çéç¼å·¥å·ï¼å®èªç¨±çºä»¥å¤ªåææéç¼ç°å¢ä¸­æå¿«ãææå½æ§ãæ´åæ§æå¼·çä¸æ¬¾ãé£å®æ¹ç github ä¸­é½èªå·±æ¿ä¾åç¥åå·¥å· dapptools äºç¸æ¯è¼ï¼çæç¶ç¶æ¯å¤§åï¼ä¸ç¶ä¸ææ¿åºä¾æ¯ï¼ã

Foundry è½å¤ å¾ç¾å¤å·¥å·ä¸­è«ç©èåºçç¹é»é¤äºå¿«éä¹å¤ï¼éæä»¥ Solidity æ°å¯«æ¸¬è©¦éåç¹è³ªï¼å¾ææåæææ©æç´°ç´°åå³çï¼

### Comparison

ä»¥ä¸æ¯ä¸äºæ¯è¼åºæºåç¸éæè¿°ï¼ç¿»è­¯æ¼ Foundry å®æ¹æä»¶ï¼

Forge å©ç¨ [ethers-solc](https://github.com/gakonst/ethers-rs/tree/master/ethers-solc/) ï¼å¨ç·¨è­¯åæ¸¬è©¦çè¡¨ç¾ä¸é½æéå¸¸å¿«çéåº¦ã

| Project                                             | Forge | DappTools | Speedup |
| --------------------------------------------------- | ----- | --------- | ------- |
| [guni-lev](https://github.com/hexonaut/guni-lev/)   | 28.6s | 2m36s     | 5.45x   |
| [solmate](https://github.com/Rari-Capital/solmate/) | 6s    | 46s       | 7.66x   |
| [geb](https://github.com/reflexer-labs/geb)         | 11s   | 40s       | 3.63x   |
| [vaults](https://github.com/rari-capital/vaults)    | 1.4s  | 5.5s      | 3.9x    |

ç¶æåå¨[æ¸¬è©¦ï¼testedï¼](https://twitter.com/gakonst/status/1461289225337421829) èåçå½å¼åº« [`openzeppelin-contracts`](https://github.com/OpenZeppelin/openzeppelin-contracts) æï¼Hardhat èè²»äº 15.244s çæéç·¨è­¯ï¼è Forge åªéè¦ 9.449s (~4s cached)ã

### What features can use

Foundry ç±ä»¥ä¸å©èçµæï¼
- [**Forge**](https://github.com/gakonst/foundry/tree/master/forge)ï¼ å°±åæåå¹³å¸¸ä½¿ç¨çå¶ä»éç¼å·¥å·ä¸æ¨£ï¼æ¯ä¸å Ethereum çæ¸¬è©¦æ¡æ¶ã
- [**Cast**](https://github.com/gakonst/foundry/tree/master/cast)ï¼æ¯æ´å¤ç¨®å®¢æ¶ç«¯åè½ï¼åæ¯è EVM æºè½åç´äºåãå³éäº¤æãåå¾éä¸è³è¨ç­ï¼å°±åä¸æçå£«åä¸æ¨£ï¼å®æ¹æä»¶å¯«çï¼ã

ä¾èªå®æ¹ç Foundry ç¹æ§ï¼
* Fast & flexible compilation pipeline
    * Automatic Solidity compiler version detection & installation (under ~/.svm)
    * Incremental compilation & caching: Only changed files are re-compiled
    * Parallel compilation
    * Non-standard directory structures support (e.g. Hardhat repos)
* Tests are written in Solidity (like in DappTools)
* Fast fuzz testing with shrinking of inputs & printing of counter-examples
* Fast remote RPC forking mode, leveraging Rust's async infrastructure like tokio
* Flexible debug logging
    * Dapptools-style, using DsTest's emitted logs
    * Hardhat-style, using the popular console.sol contract
* Portable (5-10MB) & easy to install without requiring Nix or any other package manager
* Fast CI with the Foundry GitHub action.

### Download Foundry

å¦æä½æ¥­ç³»çµ±æ¯ Linux æ macOS æç°¡å®çæ¹æ³å°±æ¯ä½¿ç¨ä»¥ä¸æ¹æ³ä¸è¼ Foundryï¼
```javascript
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

ä¸è¼å®æä¹å¾åå·è¡ä¸æ¬¡ `foundryup` æå° Foundry æ´æ°è³ææ°çæ¬ï¼å¦ææ³è¦è¿åå°æå®çæ¬ï¼ä¹å¯ä»¥ä½¿ç¨æä»¤ `foundryup -v $VERSION`ã

ç¶èæèªå·±æ¯ä½¿ç¨ Windowsï¼ä¸è¼çæ¹å¼å¦ä¸ã

å¨ä¸è¼ Foundry ä¹åï¼æåçéè¦åæºåå¥½ Rust å Cargoï¼é¦åå° rustup.rs ä¸è¼ rustï¼ç¶å¾å·è¡ï¼
```javascript
rustup-init
```

éæ¨£å°±å¯ä»¥åææºåå¥½ Rust å Cargoï¼æå¾æé CMD ä½¿ç¨ä»¥ä¸æä»¤å°±å¯ä»¥æåå®è£ Foundryã
```javascript
cargo install --git https://github.com/gakonst/foundry --bins --locked
```

å¦æå¨ä¸è¼éç¨ä¸­åæä¸æ¨£éå°ä»¥ä¸é¯èª¤ï¼
```javascript
error: linker link.exe not found
  |
  = note: program not found

note: the msvc targets depend on the msvc linker but link.exe was not found

note: please ensure that VS 2013, VS 2015, VS 2017 or VS 2019 was installed with the Visual C++ option

error: could not compile proc-macro2 due to previous error
warning: build failed, waiting for other jobs to finish...
error: failed to compile `foundry-cli v0.1.0 (https://github.com/gakonst/foundry#d66f9d58)`, intermediate artifacts can be found at C:\Users\qazws\AppData\Local\Temp\cargo-installe6Rd6Y

Caused by:
  build failed
```
é£å°±è¦ä¸è¼ [ Visual Studio 2019 Build tools](https://www.blogger.com/null)ï¼é¸æ C++ Build Tools ç¶å¾ééæ©å°±å¯ä»¥è§£æ±ºäºï¼ä¸è¼å¤§å°ç´æ¯ 6 GBã

### First Foundry Test

é¦åæåä½¿ç¨ `init` åå§åä¸åå°æ¡ã
```javascript
$ forge init hello_foundry
```

é²å° `hello_foundry` ççåå§åä¹å¾å¨è³æå¤¾è£¡é¢åºç¾äºä»éº¼ï¼
```javascript
$ cd hello_foundry
$ tree .
.
âââ lib
âÂ Â  âââ ds-test
âââ src
    âââ Contract.sol
    âââ test
        âââ Contract.t.sol

6 directories, 7 files
```

forge CLI å°æåµå»ºå©åæªæ¡ç®éï¼`lib` å `src`ã

* `lib` åå«äº testing contract (lib/ds-test/src/test.sol)ï¼åæä¹æå¶ä»åå¼åæ¨£æ¸¬è©¦åç´çå¯¦ä½ demo(lib/ds-test/demo/demo.sol)
* `src` æ¾äºæåå¯«çæºè½åç´åæ¸¬è©¦çåå§ç¢¼

ç·¨è­¯ï¼
```javascript
$ forge build
>
[2K[1m[[32mâ °[0;1m][0m Compiling...
[2K[1m[[32mâ [0;1m][0m installing solc version "0.8.10"
[2K[1m[[32mâ [0;1m][0m Successfully installed solc 0.8.10
[2K[1m[[32mâ [0;1m][0m Compiling 3 files with 0.8.10
Compiler run successful
```

é²è¡æ¸¬è©¦ï¼
```javascript
$ forge test
>
No files changed, compilation skipped
Running 1 test for ContractTest.json:ContractTest
[32m[PASS][0m testExample() (gas: 120)

```

### More Foundry Test

å¨ `$ iParking_foundry\hello_foundry\src\Contract.sol` ä¸­æåæåç´ä¿®æ¹ææåæ³è¦æ°å¯«çå¶ä»åç´ï¼

```solidity=
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Foo {
  uint256 public x = 1;
  function set(uint256 _x) external {
    x = _x;
  }

  function double() external {
    x = 2 * x;
  }
}
```

å¨æªæ¡ `test/Contract.t.sol` ä¸­ï¼
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "ds-test/test.sol";
import 'src/Contract.sol';

contract FooTest is DSTest {
  Foo foo;

  // The state of the contract gets reset before each
  // test is run, with the `setUp()` function being called
  // each time after deployment. Think of this like a JavaScript
  // `beforeEach` block
  function setUp() public {
    foo = new Foo();
  }

  // A simple unit test
  function testDouble() public {
    require(foo.x() == 1);
    foo.double();
    require(foo.x() == 2);
  }

  // A failing unit test (function name starts with `testFail`)
  function testFailDouble() public {
    require(foo.x() == 1);
    foo.double();
    require(foo.x() == 4);
  }
}
```

é²è¡æ¸¬è©¦ï¼
```javascript=
forge test
>
[2K[1m[[32mâ °[0;1m][0m Compiling...
[2K[1m[[32mâ [0;1m][0m Compiling 2 files with 0.8.10
Compiler run successful

Running 2 tests for FooTest.json:FooTest
[32m[PASS][0m testDouble() (gas: 9316)
[32m[PASS][0m testFailDouble() (gas: 9290)
```

é¤äºä»¥ä¸æåæçæç `require` ä¹å¤ï¼ä¹å¯ä»¥ä½¿ç¨ä»¥ä¸æ¹å¼é²è¡æ¸¬è©¦ï¼
```solidity=
function testDouble() public {
    assertEq(foo.x(), 1);
    foo.double();
    assertEq(foo.x(), 2);
}
```

æåéææ´å¤é·ç«ç assertions èªæ³å¯ä»¥ç¨ä¾æ¸¬è©¦åç´ï¼å¨ `lib/ds-test/src/test.sol` ä¸­å¯ä»¥æ¾å°ä»åï¼
* éè¼¯éç® - `assertTrue`
* åé²å¶ç¸ç­ - `assertEqDecimal`
* å¤§æ¼ãå°æ¼ - `assertGt`, `assertGe`, `assertLt`, `assertLe`


### More features can use

Foundry åæ¨£ä¹æ¯æ [Fuzzing](https://en.wikipedia.org/wiki/Fuzzing) æ¸¬è©¦ãå çºç¶æåä¸åä¸åå½å¼é½é²è¡æ¸¬è©¦æï¼å³ä¾¿å¨é¨é½æå PASSï¼ä½å¨ééæ¸¬è³ä¸­å¶å¯¦ä¹å¾æå¯è½æåºç¾ä¸äºåé¡ï¼å°è´ Under/Overflow æå¶ä» RE/ME ä¹é¡çé¯èª¤ã

æåå¨æ¸¬è©¦å½å¼ä¸­å¢å åæ¸ä¹å¾ï¼Fuzzing è½å¤ è® Solidity test runner é¨æ©é¸æå¤§éçåæ¸è¼¸å¥æåçå½å¼ã

```solidity=
function testDoubleWithFuzzing(uint256 x) public {
    foo.set(x);
    require(foo.x() == x);
    foo.double();
    require(foo.x() == 2 * x);
}
```

å¨ä»¥ä¸ä¾å­ä¸­ fuzzer æèªåå°å° `x` åè©¦åç¨®é¨æ©æ¸ï¼å¦æä»ç¼ç¾ç¶åè¼¸å¥æå°è´æ¸¬è©¦å¤±æï¼ä¾¿æåå³é¯èª¤ï¼éæåå°±å¯ä»¥éå§ debug å¦ï¼

é²è¡æ¸¬è©¦ï¼
```javascript
$ forge test
>
[2K[1m[[32mâ [0;1m][0m Compiling...
[2K[1m[[32mâ [0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful

Running 3 tests for FooTest.json:FooTest
[32m[PASS][0m testDouble() (gas: 9384)
[31m[FAIL. Reason: Arithmetic over/underflow. Counterexample: calldata=0xc80b36b68000000000000000000000000000000000000000000000000000000000000000, args=[57896044618658097711785492504343953926634992332820282019728792003956564819968]][0m testDoubleWithFuzzing(uint256) (runs: 4, Î¼: 2867, ~: 3823)
[32m[PASS][0m testFailDouble() (gas: 9290)

Failed tests:
[31m[FAIL. Reason: Arithmetic over/underflow. Counterexample: calldata=0xc80b36b68000000000000000000000000000000000000000000000000000000000000000, args=[57896044618658097711785492504343953926634992332820282019728792003956564819968]][0m testDoubleWithFuzzing(uint256) (runs: 4, Î¼: 2867, ~: 3823)

Encountered a total of [31m1[0m failing tests, [32m2[0m tests succeeded
```

å¾ä»¥ä¸é¯èª¤å¯ä»¥ç¼ç¾ç¶åæ¸è¼¸å¥çº `57896044618658097711785492504343953926634992332820282019728792003956564819968` ä¹å¾æåºç¾é¯èª¤ï¼ä¾å° [wolframe](https://www.wolframalpha.com/) è²¼ä¸éåæ¸å­ä¹å¾æç¼ç¾éåæ¸å­çº `5.789 * 10^76 ~= 2^255`ã

è½èµ·ä¾åååçå çº `x` çåæå°±æ¯ `uint256`ï¼æä»¥å¦æè¦é¿åç¨å¼åºç¾åé¡ï¼å¢å¿è¦å¨å½å¼è£¡é¢å¢å ä¸äºéæ¼åæçç°å¸¸èçæè¿°ã

æªä¾ Foundry é¤äºFuzz Testing ä¹å¤ï¼éææ¯æ´ï¼
* Invariant Testing
* Symbolic Execution
* Mutation Testing

:::info
Give me more information!!
* [foundry-book](https://onbjerg.github.io/foundry-book/)

Give me more more more documentation!!!
* [forge package](https://github.com/gakonst/foundry/blob/master/forge/README.md)
* [CLI README](https://github.com/gakonst/foundry/blob/master/cli/README.md).
:::

---

## â Testing Time

### Initialization & Preparation

æéä¸åç©ºè³æå¤¾ï¼ä½¿ç¨ `init` ä¾åå§åå°æ¡ï¼

```javascript
$ forge init iParking_foundry
```

å çºæåè¦ç¹¼æ¿è¨±å¤ OpenZeppelin çåç´ï¼æä»¥ééåå°å¶å°å¥å°å°æ¡ç src è£¡é¢ã

> å¶å¯¦æè¦ºä¸æ¯è¦éæ¨£å­åï¼ä½ééå¦æææ­£ç¢ºçåæ³æè¨æä¾çµ¦æ ð¥

```javascript
$ cd src
$ tree
>
ââcontracts
â  ââaccess
â  ââfinance
â  ââgovernance
â  â  ââcompatibility
â  â  ââextensions
â  â  ââutils
â  ââinterfaces
â  ââmetatx
â  ââmocks
â  â  ââcompound
â  â  ââERC165
â  â  ââUUPS
â  â  ââwizard
â  ââproxy
â  â  ââbeacon
â  â  ââERC1967
â  â  ââtransparent
â  â  ââutils
â  ââsecurity
â  ââtoken
â  â  ââcommon
â  â  ââERC1155
â  â  â  ââextensions
â  â  â  ââpresets
â  â  â  ââutils
â  â  ââERC20
â  â  â  ââextensions
â  â  â  ââpresets
â  â  â  ââutils
â  â  ââERC721
â  â  â  ââextensions
â  â  â  ââpresets
â  â  â  ââutils
â  â  ââERC777
â  â      ââpresets
â  ââutils
â      ââcryptography
â      ââescrow
â      ââintrospection
â      ââmath
â      ââstructs
ââtest
```

å¨ `$ iParking_foundry\src\Contract.sol` ä¸­æåæåç´ä¿®æ¹æååæ¿ç NFT åç´ï¼è¨å¾è¦ import è¦ç¹¼æ¿çåç¥åå®åï¼ï¼
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract CarMan is ERC721Enumerable, Ownable {

    // skip the contract here...
}
```

åæä¹åæ `Contract.t.sol` æªæ¡ä¸­çæ¸¬è©¦åç´æºåå¥½ï¼
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "ds-test/test.sol";
import 'src/Contract.sol';

contract CarManTest is DSTest {
  CarMan carman;

  // The state of the contract gets reset before each
  // test is run, with the `setUp()` function being called
  // each time after deployment. Think of this like a JavaScript
  // `beforeEach` block
  function setUp() public {
    carman = new CarMan("CarMan_Metaverse", "CMM", "ipfs://QmYvJEw4LHBpaehH6mYZV9YXC372QSWL4BPFVJvUkKqRCg/", "ipfs://.../");
  }
}
```

å»ºç½®ä¸¦æ¸¬è©¦å°æ¡çç·¨è­¯ææ²æåºç¾åé¡ï¼
```javascript
$ forge test
>
[2K[1m[[32mâ [0;1m][0m Compiling...
[2K[1m[[32mâ [0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful
```

### Unit Testing

ç®æ¨ä¸»è¦æ¯ç `preSaleMint()` éåå½å¼çéä½çæ³ï¼èªªå°åºæééä¹æ¯å±¬æ¼ä¸ç¨®é¦¬å¾ç®çè¡çºï¼å çºæä¹æ¶å¾å¯«å¥çæ¸¬è©¦åååååã

å»¢è©±ä¸å¤èªªï¼ç´æ¥éæ¸¬ï¼

```solidity=
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import '../Contract.sol';

contract CarManTest is DSTest {
  CarMan carman;
  address DEPLOYER_ADDRESS;
  address[] public temp;
  // skip the code...
}
```

é¦åå°±æ¯åå®£åçæ¬ï¼ééæé¤äºæä¸»åç´å®£åé²ä¾ä¹å¤ï¼ä¾å®£åäº `DEPLOYER_ADDRESS` ä¾å­åç´ deployer çå°åï¼ä»¥å `temp` ä¾æ«å­ä¹å¾è¦å¢é·çç½åå®ã

```solidity=
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
```

éæ®µç¨å¼ç¢¼æå¾å¤åéé»ï¼

ä¸ã`DEPLOYER_ADDRESS = carman.owner();`ï¼

éåæè¿°ä¸­æåé¦åéè¦ç¥é `msg.sender` æ¯èª°ï¼å çºå¨ deploy åç´çæåæ±ºå® `owner` æ¯èª°çæ¹æ³å°±æ¯çæä¸éå§ç `msg.sender`ã
æåå¯ä»¥å¾ `foundry.toml` ä»¥å [foundry.toml Reference](https://onbjerg.github.io/foundry-book/reference/config.html) ä¸­å¾å°ååç°å¢è®æ¸ãå¨åè®æ¸çè¨­å®æªèå¶é è¨­å¼æ¯å¤å°ã

äºã`carman.addController(DEPLOYER_ADDRESS);`ï¼

éæ¯é¤äºé£åå­ç½åå®å¤æè¦ºå¾æå¼è©­çå°æ¹ï¼é£å°±æ¯æå¨ä¸»åç´è£¡é¢æ²æçè¦ä»åæ `owner` å¨å»ºæ§å­è£¡é¢å°±è¨­å®çº `Controller`ãç¶èå¤§é¨åçåè½å½å¼å±ç¶é½æ¯éè¦ `require(Controller)` èä¸æ¯ä½¿ç¨ `onlyOwner` ç `modifier`ãæä»¥æå°±å¨ééå¹«èªå·±ï¼deployerï¼å®£åäºã

ä¸ãå¢é·ç½åå®ï¼
```solidity=
for(uint i = 0; i < 800; i++){
  address randomish = address(uint160(uint(keccak256(abi.encodePacked(i, blockhash(block.number))))));
  temp.push(randomish);
}
temp.push(DEPLOYER_ADDRESS);
carman.whitelistUsers(temp);
```
ä¸»è¦çéé»çºå¦ä½å¨åç´ä¸­é¨æ©è£½é å¸³æ¶å°åï¼ç¶å¾æä»åé½å é²å» `temp` éåé£åï¼æå¾åä¸æ¬¡ `push` å° `whitelistedAddresses` ä¸­ã 

æ¥ä¸ä¾ä¸ä¸åç¨å¼ç¢¼è®æè¦æ±è¶ç´ä¹ï¼å çºå¦ææ²æå¯¦ä½ `_checkOnERC721Received` çè©±ï¼å¨ç´æ¥å®£å `_safeMint()` ä»¥å¾æççåºç¾ä»¥ä¸é¯èª¤ï¼
```
Running 1 test for CarManTest.json:CarManTest
ï¿½[31m[FAIL. Reason: ERC721: transfer to non ERC721Receiver implementer]ï¿½[0m testDeployerCanMint() (gas: 192214)

Failed tests:
ï¿½[31m[FAIL. Reason: ERC721: transfer to non ERC721Receiver implementer]ï¿½[0m testDeployerCanMint() (gas: 192214)

Encountered a total of ï¿½[31m1ï¿½[0m failing tests, ï¿½[32m0ï¿½[0m tests succeeded
```

æ ¹æææ¥å°çè³æ `_checkOnERC721Received` æä¸å verification logic å­å¨ï¼å¦æä»å¤© `to` çå°åæ¯ä¸ååç´èä¸æ¯ EOAï¼é£å°±éè¦å¯¦ä½å®ç bodyï¼éæ¨£æå¯ä»¥å¨ ERC-721 çä»é¢è£¡é¢åå³æ­£ç¢ºç 4 bytes hashã
```solidity=
  function onERC721Received(
      address, 
      address, 
      uint256, 
      bytes calldata
  )external pure returns(bytes4) {
      return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
  } 
  /*
  solved reference: https://docs.klaytn.com/smart-contract/sample-contracts/erc-721/1-erc721#3-safetransferfrom-and-transferfrom
  */
```

ç¬¬ä¸åæ¸¬è©¦ï¼ééåè©¦è©¦æ°´æº«çèªå·±ï¼Deployerï¼è½ä¸è½å¤ éé å¹¾å NFTã
```solidity=
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
```

ç¬¬äºåæ¸¬è©¦ï¼ééè¦ä½¿ç¨ Foundry æä¾çä¸åå¾é·çåè½ï¼é£å°±æ¯æåå¯ä»¥æèªå·±çèº«åè½è®æå¶ä»å¸³æ¶ï¼èæ­¤ä¾ä»¥ä¸åè§åº¦æ¸¬è©¦åç´ã

é¦åæåè¦å®£å `CheatCodes` çä»é¢ï¼ä¹å¾å¨æ¸¬è©¦åç´è£¡é¢å®£å `cheats`ãæå¾åªè¦å¨æåæ³è¦æ¸¬è©¦çåç´è£¡é¢å ä¸ `cheats.prank(address(0));` å°±å¯ä»¥æèªå·±çè§åº¦è½æ `address(0)`ã
```solidity=
interface CheatCodes {
  function prank(address) external;
}

contract CarManTest is DSTest {
  CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    
  // skip the code...
    
  function testFailNotWLMint() public {
    cheats.prank(address(0));
    carman.preSaleMint(10);
  }  
}
```

é²è¡æ¸¬è©¦ï¼
```javascript
$ forge test
>
[2K[1m[[32mâ [0;1m][0m Compiling...
[2K[1m[[32mâ [0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful

Running 3 tests for CarManTest.json:CarManTest
[32m[PASS][0m testDeployerCanMint(uint256) (runs: 256, Î¼: 972407, ~: 1198664)
[32m[PASS][0m testFailNotWLMint() (gas: 2080543)
```

### Gas Report

Foundry éæä¸åéå¸¸æè¶£çåè½é£å°±æ¯ Gas Reportï¼

```javascript
$ forge test --gas-report
>
[2K[1m[[32mâ [0;1m][0m Compiling...
No files changed, compilation skipped

Running 2 tests for CarManTest.json:CarManTest
[32m[PASS][0m testDeployerCanMint(uint256) (runs: 256, Î¼: 908620, ~: 1198597)
[32m[PASS][0m testFailNotWLMint() (gas: 2080543)
â­ââââââââââââââââââ¬ââââââââââââââââââ¬âââââââââââ¬âââââââââââ¬âââââââââââ¬ââââââââââ®
â CarMan contract â                 â          â          â          â         â
âââââââââââââââââââªââââââââââââââââââªâââââââââââªâââââââââââªâââââââââââªââââââââââ¡
â Deployment Cost â Deployment Size â          â          â          â         â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â 3269119         â 16173           â          â          â          â         â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â Function Name   â min             â avg      â median   â max      â # calls â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â addController   â 22718           â 22718    â 22718    â 22718    â 1       â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â owner           â 444             â 444      â 444      â 444      â 1       â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â preSaleMint     â 2070405         â 2070405  â 2070405  â 2070405  â 1       â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â setPreSalePause â 858             â 858      â 858      â 858      â 1       â
âââââââââââââââââââ¼ââââââââââââââââââ¼âââââââââââ¼âââââââââââ¼âââââââââââ¼ââââââââââ¤
â whitelistUsers  â 17822466        â 17822466 â 17822466 â 17822466 â 1       â
â°ââââââââââââââââââ´ââââââââââââââââââ´âââââââââââ´âââââââââââ´âââââââââââ´ââââââââââ¯
```

éå Gas æç¶æ¯æ¶èé©äººï¼å¦æè¦ç¼ç¾éåé¯èª¤çè©±ï¼å¨ `foundry.toml` ä¸­å°±éè¦æ `gasLimit` è¨­å®ææåæ³è¦çå¤§å°ä¾æ§å¶ï¼æèä½¿ç¨å¶ä»è¾¦æ³ä¹é¡ç :D

---

## ð¸ Conclusion

### Why do I not correct the contract

å¸é¢ä¸æè¨±å¤å¯¦ä½çä¾å­ï¼ç¡è«æ¯æåºæ¬ç mappingï¼é·ç«ç Merkle Tree(Hash Tree)ï¼æçè³æ¯ç¨å¾®ä¸­å¿åä½æ´ææ¼ç®¡çåç¯çéé·ç Backend Signature Whitelist Data Baseï¼å¶å¯¦å¤æ¥ä¸é»è³ææè©²æ¯æé¸æé¿åæç¨ array éåè³æçµæ§ä¾å­ç½åå®çã

ä¸éå çºææ¯ä¸åèé³¥ï¼æèªè­çæææå¯« Solidity çäººè£¡é¢æ 99% é½æ¯èªå·±å¼·åååååï¼æä»¥ä¿®æ­£æºè½åç´éç¨®äºææåèº²éå¥½äºï¼å Auditing çå¤§å¸«ä¸å°ï¼éæ¯è®ä»åä¾å§ :D


### My point of view

åºç¶ä½¿ç¨ `array` åéæ­·éæ¨£å­çæ¼ç®æ³ä¾å°æ¾ç½åå®è½ç¨±å¾ä¸æ¯è©­è­ï¼ä¸éå¾ Web2 è·¨è¶³å° Web3 çå¬å¸åï¼å¶å¯¦æå¾å¤æ±è¥¿é½éè¦å­¸ç¿ã

èä¸å¨éåæåéå§è¦è¬åç¼å±çç¢æ¥­èæè¡ä¸­ï¼è¨±å¤äººä¹é½éå¨æ¸ç´¢æå¥½çæè¡æ¨¡å¼ãåæ¥­æ¨¡å¼ãä¹è¨±çµ¦ä»åä¸åæ¹åçæ©æï¼ç´¯ç©è¶ä¾è¶å¤éæ¨£çåä¾æç¨®ç¨åº¦ä¸ä¹è½å¤ è®éåç¢æ¥­éåæ´å¥½çç¼å±ï¼

é£å¸ææå¯ä»¥å¤å¤å¤å¤å¤å¤å¢é²èªå·±å¯«æ¸¬è©¦çå¯¦åï¼ç¢ç«å¯«åºä¸åæåçåç´ä¸¦ä¸é£ï¼ä½è¦å¯«åºä¸åä¸æåºé¯çé£å¦ç»å¤©é¿ï¼

---

## ð¨ Reference

### Foundry
* [Introducing the Foundry Ethereum development toolbox](https://www.paradigm.xyz/2021/12/introducing-the-foundry-ethereum-development-toolbox#You_should_be_writing_your_tests_in_Solidity)
* [Building and testing smart contracts with Foundry](https://nader.mirror.xyz/6Mn3HjrqKLhHzu2balLPv4SqE5a-oEESl4ycpRkWFsc)
* [Getting Started With Foundry](https://www.youtube.com/watch?v=wqFnif_6Mbc)
* [Deploy a smart contract with Foundry and Chainstack](https://docs.fantom.foundation/tutorials/deploy-a-smart-contract-with-foundry-and-chainstack)
* [Foundry: A fast Solidity contract development toolkit](https://chainstack.com/foundry-a-fast-solidity-contract-development-toolkit/)

### ERC-721 Contract Unit Testing
* [Deploy A Fully Tested NFT Contract Using OpenZeppelin](https://gigster.com/blog/deploy-a-fully-tested-nft-contract-using-openzeppelin/)
* [Import & Test a Popular NFT Smart Contract with Hardhat & Ethers](https://dev.to/jacobedawson/import-test-a-popular-nft-smart-contract-with-hardhat-ethers-12i5)
* [A simple guide for how to write unit tests for smart contracts](https://medium.com/upstate-interactive/a-simple-guide-for-how-to-write-unit-tests-for-smart-contracts-8ec4b645f57b)
* [Implementing and testing an ERC721 contract](https://leftasexercise.com/2021/10/10/implementing-and-testing-an-erc721-contract/)
