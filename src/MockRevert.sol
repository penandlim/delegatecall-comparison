// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {UniswapDelegateCall} from "./UniswapDelegateCall.sol";
import {Address} from "@openzeppelin/utils/Address.sol";

contract MockRevert {
    error CustomError();
    error CustomErrorWithString(string message);

    function revertWithCustomError() public {
        revert CustomError();
    }

    function revertWithCustomErrorWithString() public {
        revert CustomErrorWithString("CustomData");
    }

    function revertWithString() public {
        revert("Old school revert");
    }

    function success() public returns (bytes32) {
        return bytes32(uint256(0xbeef));
    }

    function uniswapDelegateCall(bytes memory data) public returns (bytes memory) {
        return UniswapDelegateCall.delegateCall(data);
    }

    function ozDelegateCall(bytes memory data) public returns (bytes memory) {
        return Address.functionDelegateCall(address(this), data);
    }
}
