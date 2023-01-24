// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract cybergorilla is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
     uint public requireAmount = 2; //amount of nfts needed to claim the new nft
     uint256 public cost = 0.001 ether;//mint price is set at 0.001
     uint256 public maxSupply = 1000;//total supply for the entire collection
     uint256 public maxMintAmount = 1;
    //bool public revealed = false;
     string public notRevealedUri;
     IERC721 public overrideNFT;
     uint256 maxMintedAmount = 1;
    mapping(address => uint256) private mintedPerWallet;
    uint256 public MAX_MINT_PER_TX = 1;

    constructor(address _OverrideNft) ERC721("CYBERkigdom","CYBK") {
        overrideNFT = IERC721(_OverrideNft);
    }
 
     function claim() public payable {
         require(overrideNFT.balanceOf(msg.sender) >= 2, "you dont own enough");
         // IERC721 token = IERC721(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);//address of the nft required to claim this
          uint256 Ownedtoken = overrideNFT.balanceOf(msg.sender);//checking to see how many tokens is owned by the msg.sender
          require(Ownedtoken >= requireAmount, "you dont own any cyberKingdom nft");
           require(mintedPerWallet[msg.sender] <= MAX_MINT_PER_TX, "you can mint once");
           require(msg.value == 0.001 ether, "insufficient eth");
           uint256 supply = totalSupply(); 
           require(supply + 1 <= 1000); 
        //   uint256 tokenId = _tokenIdCounter.current();
        //  _tokenIdCounter.increment();
          _safeMint(msg.sender, supply + 1);
          //approve(address(this), tokenId);
          //overrideNFT.burn(tokenId); // @TODO: Need to either pass tokenId as arg or gather it another way
         // _transfer(msg.sender, address(0x17F6AD8Ef982297579C203069C1DbfFE4348c372), tokenId);
       //  _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}