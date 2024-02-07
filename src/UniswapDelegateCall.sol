// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {console2 as console} from "forge-std/console2.sol";

// From https://github.com/Uniswap/v3-periphery/blob/697c2474757ea89fec12a4e6db16a574fe259610/contracts/base/Multicall.sol
// Console logging is added for debugging purposes
library UniswapDelegateCall {
    function delegateCall(bytes memory data) internal returns (bytes memory) {
        (bool success, bytes memory result) = address(this).delegatecall(data);
        if (!success) {
            // Next 5 lines from https://ethereum.stackexchange.com/a/83577
            if (result.length < 68) revert();
            assembly {
                result := add(result, 0x04)
            }
            console.log("UniswapDelegateCall: After moving result pointer by 4, result.length =", result.length);
            console.logBytes32(bytes32(result.length));
            revert(abi.decode(result, (string)));
        }
        return result;
    }
}
