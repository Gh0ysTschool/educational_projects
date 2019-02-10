pragma solidity ^0.4.25;
import "./zombieattack.sol";
import "./erc721.sol";
contract ZombieOwnership is ZombieAttack, ERC721 {
    function balanceOf(address _owner) external view returns (uint256) {
    }
    function ownerOf(uint256 _tokenId) external view returns (address) {
    }

}