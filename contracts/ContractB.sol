// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;


import {
    SafeERC20,
    SafeMath,
    IERC20,
    Address
} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

interface IContractA {
    function sendTokens(address to) external;
}

contract ContractB {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    IERC20 public token;
    address private owner;
    IContractA private contractA;
    uint256 public magicVariable = 0;
    uint256 public otherStorage = 0;

    event MagicVariable(uint256 value);

    constructor(address _contractA) public {
      owner = msg.sender;
      contractA = IContractA(_contractA);
    }

    function sendTokens(address to) public {
      require(msg.sender == owner);
      token.transfer(to, token.balanceOf(address(this)));
    }

    function runTest() public {
      require(msg.sender == owner);
      emit MagicVariable(magicVariable);
      magicVariable = 100;
      emit MagicVariable(magicVariable);
      contractA.sendTokens(address(this));
      otherStorage = magicVariable;
      emit MagicVariable(magicVariable);
    }

}
