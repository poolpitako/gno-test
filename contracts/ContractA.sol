// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;


import {
    SafeERC20,
    SafeMath,
    IERC20,
    Address
} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

contract ContractA {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    IERC20 public token;
    address private owner;
    address private other;

    constructor(address _token) public {
      owner = msg.sender;
      token = IERC20(_token);
    }

    function sendTokens(address to) public {
      require(msg.sender == owner || msg.sender == other);
      token.transfer(to, token.balanceOf(address(this)));
    }

    function setOther(address _other) public {
      require(msg.sender == owner);
      other = _other;
    }
}
