# Testing-iParking-NFT-with-Foundry
[How To Test The Smart Contract Of iParking NFT With Foundry](https://medium.com/@ChiHaoLu/how-to-test-the-smart-contract-of-iparking-nft-with-foundry-bc8bdbe6a359)

---

# How To Test The Smart Contract Of iParking NFT With Foundry 

---

###### tags: `TOPIC`
:::warning
⚠️ **Of course this is only my personal thoughts, don't be too serious haha...** ⚠️
:::
**Final Updated: 2022/3/17**

---

## 🚁 Table of Contents

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

## 😿 Intro.

### iParking NFT & What happened?

簡單來說我對事件的起因和過程也不是有著什麼深度的了解，主要接收資訊的來源也就是以下兩者，在這邊我就附上連結讓大家自行參考了！

* [嘟嘟房 NFT 白名單出包？網爆料「花上百美元手續費還失敗」，官方回應：Gas Limit 設太低](https://www.blocktempo.com/iparking-nft-mint-failed-due-to-low-gas-limit/)
* [嘟嘟房NFT出包事件懶人包 - FulyAI Founder Rex Chen](https://medium.com/fuly-ai-%E6%99%BA%E8%83%BD%E6%8A%95%E8%B3%87%E7%AD%96%E7%95%A5%E6%A9%9F%E5%99%A8%E4%BA%BA-bitfinex-%E6%94%BE%E8%B2%B8%E6%A9%9F%E5%99%A8%E4%BA%BA/%E5%98%9F%E5%98%9F%E6%88%BFnft%E5%87%BA%E5%8C%85%E4%BA%8B%E4%BB%B6%E6%87%B6%E4%BA%BA%E5%8C%85-4a4acd7fe0c2)

### Motivation

我發現好像沒有看到人選擇以在合約部屬「前」會進行「測試」的角度來看這次的事件，而是在錯誤發生「後」用「肉眼」觀察合約來找到問題在哪。講這些並不是要說任何評論這件事情的好前輩和好夥伴們的不是！真正錯的也就只有開發團隊，還有沒有做好事後處理的 MOD 而已。

固然這次的錯誤是肉眼清晰可見的，而且水汪汪的大眼睛和大腦某些時候確實是比手打程式碼好用許多的哈哈哈哈。

不過 Testing 是我認為成為一個職業工程師一個很重要的檻，我自認為距離一個真正的工程師還有不小的距離，所以想要藉此機會來練習一下用之前陳品大大告訴我的 Foundry 撰寫測試！

這篇文章的主軸其實還是我自己學習 Foundry 的小小筆記，嘟嘟房只是一個活例而已 :D

那在開始之前，先回到整個文章最一開始的宣告：

:::warning
⚠️ **Of course this is only my personal thoughts, don't be too serious haha...** ⚠️
:::

> 大家如果發現文中的任何錯誤或有任何想法，請不吝、大方地告訴我，因為還在學習中，我會無條件接受所有意見和想法的！

---

## 🔎 Cast an eye over the contract

現在我們參考上述前輩和媒體的資料，大概率可以先把技術層面的問題定位在：
1. 使用 `array` 這個資料結構來實作白名單系統
2. Gas Limit 的設定問題

那是時候來看程式碼啦！

[iParking NFT Source Code in Etherscan.io](https://etherscan.io/address/0xae122962331c2b02f837b2aa501d3c5d903ed28a#code)

### The path of the Contract Inheritance

這邊基本上我是順過去的，我猜嘟嘟房的工程師應該，應該，應該沒有特別去改這些繼承而來的合約內容吧！如果有的話我先道歉><

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

但其實 OpenZeppelin 裡面有許多用不到的東西（變數、資料結構、宣告等）可以刪掉，能藉此來把 Gas Fee 降低。所以我自己在寫 Project 的時候都會習慣不要直接繼承 Github 上面的內容，而是把需要的東西貼過來一個一個改成想要的樣子。

OpenZeppelin 的安全性和便利性是許多人所稱許的，可對我們這些科學家/工程師（像我這種菜雞可能是半個）來說，細細的斟酌一下我們要使用的東西也蠻重要的對吧！

如果自己隨便亂改然後合約反而出現 Bug，那確實是拿石頭砸自己腳。我就很常這樣，哈哈...

> 不過畢竟工作是有收薪水的，不管是繼承函式庫還是呼叫 API 都得要更小心。隨著我自己更深入地了解這門技術，才發現很多時候程式碼不是只有 Copy-Paste 那麼簡單。

### CarMan

那我們就直接看到繼承了歷代先祖先烈們的遺產，準備迎來人生曙光的最後主合約吧！

我並不會非常仔細的一一講解合約裡面的每個變數、函式的細節，這邊就是去大概摸出合約裡面有什麼東西而已。那希望大家隨著我文中的引用程式碼一起來看看裡面到底都寫了什麼吧！

最開始都是宣告版本、宣告合約以及繼承，進到合約之後先宣告了一些常數：
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

馬上就遇到第一個被大家拿出來鞭的小夥伴，`array` 型態的 `whitelistedAddresses`：
```solidity=
  bool public revealed = false;
  bool public onlyWhitelisted = true;
  address[] whitelistedAddresses;

  mapping(address => uint256) addressMintedBalance;
  mapping(address => uint256) vipMintAmount;

  // addresses to manage this contract
  mapping(address => bool) controllers;
```
 
負責接收初始化參數們的建構子，還有指到 NFT Metadata 的 `baseURI`，如果是存在 IPFS 的話那就是他的 CID：
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

給 VIP 們 `mint` 的函式：
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

預售用的 `mint` 函式：
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

公售用的 `mint` 函式：
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

判斷當前訊息傳遞者（如果是交易或者 `mint` 那 `msg.sender` 自然是消費者）是否為白名單成員：
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

正常的 NFT 合約有的 `tokenURI`：
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

關於一些鑄造函式的啟動 & 關閉條件。
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

是一些擁有管理權的人們才能呼叫的函式。通常這種函式越多我覺得就越中心化，不過既然一切都是透明且清楚明白的寫在程式碼上，其實 sign 了就代表我們同意接受這個合約對吧！
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

控制權，在這個合約裡面也算是管理權的人員管理函式：
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

賺了錢記得要把錢拿出來的 `withdraw` 函式：
```solidity=
  function withdraw() public onlyOwner {
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }
}
```

---

## 📜 What is Foundry!?

### Unit Testing of Smart Contract

過往我們在進行 Testing 的時候無非是使用 Hardhat, Truffle, DappTools 等撰寫 Javascript/ Typescript 語法的測試，最後搭配 Ganache, Infura 等來服用。其他藥物還會包含 ethers.js, mocha, waffle, chai 之類的 blablabla，大家自行體會 :D

但有寫過的人可能都知道，在我們的 node_modules 裡面應該充滿了各式各樣的 dependencies，做任何開發之前都要先來一套刪套件、重載套件、降版本、環境變數之類的組合拳，也算是夠惱人的...

雖然 Javascript 已經是一個人手一把的利器，但身為一個撰寫 Solidity 的工程師測試卻要用另外一個語言來寫，總是會覺得哪裡怪怪的（嗎）。更不用說 Big Number 這個套件某些時候還會造成一些問題。

不過現在能夠用 Solidity 一劑打天下的疫苗出現了，那就是效果快狠準的 Foundry！（掌聲歡迎🎉🎉）

### Introduction

[**Foundry**](https://github.com/gakonst/foundry) 是一個使用 Rust 建置的開發工具，它自稱為以太坊所有開發環境中最快、最有彈性、擴充性最強的一款。連官方的 github 中都自己拿來和知名工具 dapptools 互相比較（理所當然是大勝，不然不會拿出來比）。

Foundry 能夠從眾多工具中脫穎而出的特點除了快速之外，還有以 Solidity 撰寫測試這個特質，待會我們會有機會細細品味的！

### Comparison

以下是一些比較基準和相關敘述，翻譯於 Foundry 官方文件：

Forge 利用 [ethers-solc](https://github.com/gakonst/ethers-rs/tree/master/ethers-solc/) ，在編譯和測試的表現上都有非常快的速度。

| Project                                             | Forge | DappTools | Speedup |
| --------------------------------------------------- | ----- | --------- | ------- |
| [guni-lev](https://github.com/hexonaut/guni-lev/)   | 28.6s | 2m36s     | 5.45x   |
| [solmate](https://github.com/Rari-Capital/solmate/) | 6s    | 46s       | 7.66x   |
| [geb](https://github.com/reflexer-labs/geb)         | 11s   | 40s       | 3.63x   |
| [vaults](https://github.com/rari-capital/vaults)    | 1.4s  | 5.5s      | 3.9x    |

當我們在[測試（tested）](https://twitter.com/gakonst/status/1461289225337421829) 著名的函式庫 [`openzeppelin-contracts`](https://github.com/OpenZeppelin/openzeppelin-contracts) 時，Hardhat 耗費了 15.244s 的時間編譯，而 Forge 只需要 9.449s (~4s cached)。

### What features can use

Foundry 由以下兩者組成：
- [**Forge**](https://github.com/gakonst/foundry/tree/master/forge)： 就像我們平常使用的其他開發工具一樣，是一個 Ethereum 的測試框架。
- [**Cast**](https://github.com/gakonst/foundry/tree/master/cast)：支援多種客戶端功能，像是與 EVM 智能合約互動、傳遞交易、取得鏈上資訊等，就像一把瑞士刀一樣（官方文件寫的）。

來自官方的 Foundry 特性：
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

如果作業系統是 Linux 或 macOS 最簡單的方法就是使用以下方法下載 Foundry：
```javascript
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

下載完成之後再執行一次 `foundryup` 會將 Foundry 更新至最新版本，如果想要返回到指定版本，也可以使用指令 `foundryup -v $VERSION`。

然而我自己是使用 Windows，下載的方式如下。

在下載 Foundry 之前，我們的需要先準備好 Rust 和 Cargo，首先到 rustup.rs 下載 rust，然後執行：
```javascript
rustup-init
```

這樣就可以同時準備好 Rust 和 Cargo，最後打開 CMD 使用以下指令就可以成功安裝 Foundry。
```javascript
cargo install --git https://github.com/gakonst/foundry --bins --locked
```

如果在下載過程中像我一樣遇到以下錯誤：
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
那就要下載 [ Visual Studio 2019 Build tools](https://www.blogger.com/null)，選擇 C++ Build Tools 然後重開機就可以解決了！下載大小約是 6 GB。

### First Foundry Test

首先我們使用 `init` 初始化一個專案。
```javascript
$ forge init hello_foundry
```

進到 `hello_foundry` 看看初始化之後在資料夾裡面出現了什麼：
```javascript
$ cd hello_foundry
$ tree .
.
├── lib
│   └── ds-test
└── src
    ├── Contract.sol
    └── test
        └── Contract.t.sol

6 directories, 7 files
```

forge CLI 將會創建兩個檔案目錄：`lib` 和 `src`。

* `lib` 包含了 testing contract (lib/ds-test/src/test.sol)，同時也有其他各式各樣測試合約的實作 demo(lib/ds-test/demo/demo.sol)
* `src` 放了我們寫的智能合約和測試的原始碼

編譯：
```javascript
$ forge build
>
[2K[1m[[32m⠰[0;1m][0m Compiling...
[2K[1m[[32m⠃[0;1m][0m installing solc version "0.8.10"
[2K[1m[[32m⠒[0;1m][0m Successfully installed solc 0.8.10
[2K[1m[[32m⠊[0;1m][0m Compiling 3 files with 0.8.10
Compiler run successful
```

進行測試：
```javascript
$ forge test
>
No files changed, compilation skipped
Running 1 test for ContractTest.json:ContractTest
[32m[PASS][0m testExample() (gas: 120)

```

### More Foundry Test

在 `$ iParking_foundry\hello_foundry\src\Contract.sol` 中我們把合約修改成我們想要撰寫的其他合約：

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

在檔案 `test/Contract.t.sol` 中：
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

進行測試：
```javascript=
forge test
>
[2K[1m[[32m⠰[0;1m][0m Compiling...
[2K[1m[[32m⠒[0;1m][0m Compiling 2 files with 0.8.10
Compiler run successful

Running 2 tests for FooTest.json:FooTest
[32m[PASS][0m testDouble() (gas: 9316)
[32m[PASS][0m testFailDouble() (gas: 9290)
```

除了以上我們最熟悉的 `require` 之外，也可以使用以下方式進行測試：
```solidity=
function testDouble() public {
    assertEq(foo.x(), 1);
    foo.double();
    assertEq(foo.x(), 2);
}
```

我們還有更多酷炫的 assertions 語法可以用來測試合約，在 `lib/ds-test/src/test.sol` 中可以找到他們：
* 邏輯運算 - `assertTrue`
* 十進制相等 - `assertEqDecimal`
* 大於、小於 - `assertGt`, `assertGe`, `assertLt`, `assertLe`


### More features can use

Foundry 同樣也支持 [Fuzzing](https://en.wikipedia.org/wiki/Fuzzing) 測試。因為當我們一個一個函式都進行測試時，即便全部都成功 PASS，但在邊際測資中其實也很有可能會出現一些問題，導致 Under/Overflow 或其他 RE/ME 之類的錯誤。

我們在測試函式中增加參數之後，Fuzzing 能夠讓 Solidity test runner 隨機選擇大量的參數輸入我們的函式。

```solidity=
function testDoubleWithFuzzing(uint256 x) public {
    foo.set(x);
    require(foo.x() == x);
    foo.double();
    require(foo.x() == 2 * x);
}
```

在以上例子中 fuzzer 會自動地對 `x` 嘗試各種隨機數，如果他發現當前輸入會導致測試失敗，便會回傳錯誤，這時候就可以開始 debug 啦！

進行測試：
```javascript
$ forge test
>
[2K[1m[[32m⠆[0;1m][0m Compiling...
[2K[1m[[32m⠔[0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful

Running 3 tests for FooTest.json:FooTest
[32m[PASS][0m testDouble() (gas: 9384)
[31m[FAIL. Reason: Arithmetic over/underflow. Counterexample: calldata=0xc80b36b68000000000000000000000000000000000000000000000000000000000000000, args=[57896044618658097711785492504343953926634992332820282019728792003956564819968]][0m testDoubleWithFuzzing(uint256) (runs: 4, μ: 2867, ~: 3823)
[32m[PASS][0m testFailDouble() (gas: 9290)

Failed tests:
[31m[FAIL. Reason: Arithmetic over/underflow. Counterexample: calldata=0xc80b36b68000000000000000000000000000000000000000000000000000000000000000, args=[57896044618658097711785492504343953926634992332820282019728792003956564819968]][0m testDoubleWithFuzzing(uint256) (runs: 4, μ: 2867, ~: 3823)

Encountered a total of [31m1[0m failing tests, [32m2[0m tests succeeded
```

從以上錯誤可以發現當參數輸入為 `57896044618658097711785492504343953926634992332820282019728792003956564819968` 之後會出現錯誤，來到 [wolframe](https://www.wolframalpha.com/) 貼上這個數字之後會發現這個數字為 `5.789 * 10^76 ~= 2^255`。

聽起來十分合理因為 `x` 的型態就是 `uint256`，所以如果要避免程式出現問題，勢必要在函式裡面增加一些關於型態的異常處理敘述。

未來 Foundry 除了Fuzz Testing 之外，還會支援：
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

## ⚗ Testing Time

### Initialization & Preparation

打開一個空資料夾，使用 `init` 來初始化專案：

```javascript
$ forge init iParking_foundry
```

因為我們要繼承許多 OpenZeppelin 的合約，所以這邊先將其導入到專案的 src 裡面。

> 其實感覺不是要這樣子做，但這邊如果有正確的做法拜託提供給我 😥

```javascript
$ cd src
$ tree
>
├─contracts
│  ├─access
│  ├─finance
│  ├─governance
│  │  ├─compatibility
│  │  ├─extensions
│  │  └─utils
│  ├─interfaces
│  ├─metatx
│  ├─mocks
│  │  ├─compound
│  │  ├─ERC165
│  │  ├─UUPS
│  │  └─wizard
│  ├─proxy
│  │  ├─beacon
│  │  ├─ERC1967
│  │  ├─transparent
│  │  └─utils
│  ├─security
│  ├─token
│  │  ├─common
│  │  ├─ERC1155
│  │  │  ├─extensions
│  │  │  ├─presets
│  │  │  └─utils
│  │  ├─ERC20
│  │  │  ├─extensions
│  │  │  ├─presets
│  │  │  └─utils
│  │  ├─ERC721
│  │  │  ├─extensions
│  │  │  ├─presets
│  │  │  └─utils
│  │  └─ERC777
│  │      └─presets
│  └─utils
│      ├─cryptography
│      ├─escrow
│      ├─introspection
│      ├─math
│      └─structs
└─test
```

在 `$ iParking_foundry\src\Contract.sol` 中我們把合約修改成嘟嘟房的 NFT 合約（記得要 import 要繼承的列祖列宗們）：
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract CarMan is ERC721Enumerable, Ownable {

    // skip the contract here...
}
```

同時也先把 `Contract.t.sol` 檔案中的測試合約準備好：
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

建置並測試專案看編譯有沒有出現問題：
```javascript
$ forge test
>
[2K[1m[[32m⠆[0;1m][0m Compiling...
[2K[1m[[32m⠘[0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful
```

### Unit Testing

目標主要是看 `preSaleMint()` 這個函式的運作狀況，說到底我這邊也是屬於一種馬後炮的行為，因為我也懶得寫別的測試哈哈哈哈哈。

廢話不多說，直接開測：

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

首先就是先宣告版本，這邊我除了把主合約宣告進來之外，來宣告了 `DEPLOYER_ADDRESS` 來存合約 deployer 的地址；以及 `temp` 來暫存之後要增長的白名單。

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

這段程式碼有很多個重點：

一、`DEPLOYER_ADDRESS = carman.owner();`：

這個敘述中我們首先需要知道 `msg.sender` 是誰，因為在 deploy 合約的時候決定 `owner` 是誰的方法就是看最一開始的 `msg.sender`。
我們可以從 `foundry.toml` 以及 [foundry.toml Reference](https://onbjerg.github.io/foundry-book/reference/config.html) 中得到各個環境變數、全域變數的設定檔與其預設值是多少。

二、`carman.addController(DEPLOYER_ADDRESS);`：

這是除了陣列存白名單外我覺得最弔詭的地方，那就是我在主合約裡面沒有看見他們把 `owner` 在建構子裡面就設定為 `Controller`。然而大部分的功能函式居然都是需要 `require(Controller)` 而不是使用 `onlyOwner` 的 `modifier`。所以我就在這邊幫自己（deployer）宣告了。

三、增長白名單：
```solidity=
for(uint i = 0; i < 800; i++){
  address randomish = address(uint160(uint(keccak256(abi.encodePacked(i, blockhash(block.number))))));
  temp.push(randomish);
}
temp.push(DEPLOYER_ADDRESS);
carman.whitelistUsers(temp);
```
主要的重點為如何在合約中隨機製造帳戶地址，然後把他們都加進去 `temp` 這個陣列，最後再一次 `push` 到 `whitelistedAddresses` 中。 

接下來下一個程式碼讓我苦惱超級久，因為如果沒有實作 `_checkOnERC721Received` 的話，在直接宣告 `_safeMint()` 以後會瘋狂出現以下錯誤：
```
Running 1 test for CarManTest.json:CarManTest
�[31m[FAIL. Reason: ERC721: transfer to non ERC721Receiver implementer]�[0m testDeployerCanMint() (gas: 192214)

Failed tests:
�[31m[FAIL. Reason: ERC721: transfer to non ERC721Receiver implementer]�[0m testDeployerCanMint() (gas: 192214)

Encountered a total of �[31m1�[0m failing tests, �[32m0�[0m tests succeeded
```

根據我查到的資料 `_checkOnERC721Received` 有一個 verification logic 存在，如果今天 `to` 的地址是一個合約而不是 EOA，那就需要實作它的 body，這樣才可以在 ERC-721 的介面裡面回傳正確的 4 bytes hash。
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

第一個測試，這邊先試試水溫看自己（Deployer）能不能夠鑄造幾個 NFT。
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

第二個測試，這邊要使用 Foundry 提供的一個很酷的功能，那就是我們可以把自己的身分轉變成其他帳戶，藉此來以不同角度測試合約。

首先我們要宣告 `CheatCodes` 的介面，之後在測試合約裡面宣告 `cheats`。最後只要在我們想要測試的合約裡面加上 `cheats.prank(address(0));` 就可以把自己的角度轉成 `address(0)`。
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

進行測試：
```javascript
$ forge test
>
[2K[1m[[32m⠒[0;1m][0m Compiling...
[2K[1m[[32m⠑[0;1m][0m Compiling 1 files with 0.8.10
Compiler run successful

Running 3 tests for CarManTest.json:CarManTest
[32m[PASS][0m testDeployerCanMint(uint256) (runs: 256, μ: 972407, ~: 1198664)
[32m[PASS][0m testFailNotWLMint() (gas: 2080543)
```

### Gas Report

Foundry 還有一個非常有趣的功能那就是 Gas Report：

```javascript
$ forge test --gas-report
>
[2K[1m[[32m⠔[0;1m][0m Compiling...
No files changed, compilation skipped

Running 2 tests for CarManTest.json:CarManTest
[32m[PASS][0m testDeployerCanMint(uint256) (runs: 256, μ: 908620, ~: 1198597)
[32m[PASS][0m testFailNotWLMint() (gas: 2080543)
╭─────────────────┬─────────────────┬──────────┬──────────┬──────────┬─────────╮
│ CarMan contract ┆                 ┆          ┆          ┆          ┆         │
╞═════════════════╪═════════════════╪══════════╪══════════╪══════════╪═════════╡
│ Deployment Cost ┆ Deployment Size ┆          ┆          ┆          ┆         │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ 3269119         ┆ 16173           ┆          ┆          ┆          ┆         │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ Function Name   ┆ min             ┆ avg      ┆ median   ┆ max      ┆ # calls │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ addController   ┆ 22718           ┆ 22718    ┆ 22718    ┆ 22718    ┆ 1       │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ owner           ┆ 444             ┆ 444      ┆ 444      ┆ 444      ┆ 1       │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ preSaleMint     ┆ 2070405         ┆ 2070405  ┆ 2070405  ┆ 2070405  ┆ 1       │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ setPreSalePause ┆ 858             ┆ 858      ┆ 858      ┆ 858      ┆ 1       │
├╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌╌┼╌╌╌╌╌╌╌╌╌┤
│ whitelistUsers  ┆ 17822466        ┆ 17822466 ┆ 17822466 ┆ 17822466 ┆ 1       │
╰─────────────────┴─────────────────┴──────────┴──────────┴──────────┴─────────╯
```

這個 Gas 果然是消耗驚人，如果要發現這個錯誤的話，在 `foundry.toml` 中就需要把 `gasLimit` 設定成我們想要的大小來控制，或者使用其他辦法之類的 :D

---

## 💸 Conclusion

### Why do I not correct the contract

市面上有許多實作的例子，無論是最基本的 mapping，酷炫的 Merkle Tree(Hash Tree)，或甚至是稍微中心化但更易於管理和節省開銷的 Backend Signature Whitelist Data Base，其實多查一點資料應該是會選擇避免掉用 array 這個資料結構來存白名單的。

不過因為我是一個菜鳥，我認識的所有會寫 Solidity 的人裡面有 99% 都比自己強哈哈哈哈哈，所以修正智能合約這種事情我先躲開好了！做 Auditing 的大師不少，還是讓他們來吧 :D


### My point of view

固然使用 `array` 和遍歷這樣子的演算法來尋找白名單能稱得上是詭譎，不過從 Web2 跨足到 Web3 的公司們，其實有很多東西都需要學習。

而且在這個才剛開始要蓬勃發展的產業與技術中，許多人也都還在摸索最好的技術模式、商業模式。也許給他們一個改善的機會，累積越來越多這樣的先例某種程度上也能夠讓這個產業邁向更好的發展！

那希望我可以多多多多多多增進自己寫測試的實力，畢竟寫出一個會動的合約並不難，但要寫出一個不會出錯的難如登天阿！

---

## 🎨 Reference

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
