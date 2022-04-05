//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ReeseToken {
  string public constant NAME = "ReeseToken";
  string public constant SYMBOL = "REE";
  uint8 public constant DECIMALS = 18;

  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
  event Transfer(address indexed from, address indexed to, uint tokens);

  mapping(address => uint256) private balances;

  mapping(address => mapping (address => uint256)) private allowed;

  uint256 private totalSupply_;

  using SafeMath for uint256;

  constructor(uint256 total) {
    totalSupply_ = total;
    balances[msg.sender] = totalSupply_;
  }

  function totalSupply() public view returns (uint256) {
	  return totalSupply_;
  }

  function balanceOf(address tokenOwner) public view returns (uint) {
    return balances[tokenOwner];
  }

  function transfer(address receiver, uint numTokens) public returns (bool) {
    require(numTokens <= balances[msg.sender], "Insufficient tokens to transfer");
    balances[msg.sender] = balances[msg.sender].sub(numTokens);
    balances[receiver] = balances[receiver].add(numTokens);
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
  }

  function approve(address delegate, uint numTokens) public returns (bool) {
    allowed[msg.sender][delegate] = numTokens;
    emit Approval(msg.sender, delegate, numTokens);
    return true;
  }

  function allowance(address owner, address delegate) public view returns (uint) {
    return allowed[owner][delegate];
  }

  function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
    require(numTokens <= balances[owner], "Insufficient tokens to transfer");
    require(numTokens <= allowed[owner][msg.sender], "Lack approval for token count");

    balances[owner] = balances[owner].sub(numTokens);
    allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
    balances[buyer] = balances[buyer].add(numTokens);
    emit Transfer(owner, buyer, numTokens);
    return true;
  }
}

library SafeMath {
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}