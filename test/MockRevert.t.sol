// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MockRevert} from "../src/MockRevert.sol";

contract MockRevertTest is Test {
    MockRevert public mockRevert;

    function setUp() public {
        mockRevert = new MockRevert();
    }

    function test_ozDelegateCall_success() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.success.selector);
        bytes memory result = mockRevert.ozDelegateCall(data);
        assertEq(result, abi.encodePacked(bytes32(uint256(0xbeef))));
    }

    function test_ozDelegateCall_revertWithCustomError() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithCustomError.selector);
        vm.expectRevert(MockRevert.CustomError.selector);
        mockRevert.ozDelegateCall(data);
    }

    function test_ozDelegateCall_revertWithCustomErrorWithString() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithCustomErrorWithString.selector);
        vm.expectRevert(abi.encodeWithSelector(MockRevert.CustomErrorWithString.selector, "CustomData"));
        mockRevert.ozDelegateCall(data);
    }

    function test_ozDelegateCall_revertWithString() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithString.selector);
        vm.expectRevert("Old school revert");
        mockRevert.ozDelegateCall(data);
    }

    function test_uniswapDelegateCall_success() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.success.selector);
        bytes memory result = mockRevert.uniswapDelegateCall(data);
        assertEq(result, abi.encodePacked(bytes32(uint256(0xbeef))));
    }

    function test_uniswapDelegateCall_revertWithCustomError() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithCustomError.selector);
        vm.expectRevert(MockRevert.CustomError.selector);
        // length < 68, the empty revert is triggered
        // vm.expectRevert();
        mockRevert.uniswapDelegateCall(data);
    }

    function test_uniswapDelegateCall_revertWithCustomErrorWithString() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithCustomErrorWithString.selector);
        console.log("Custom revert signature: ");
        console.logBytes4(MockRevert.CustomErrorWithString.selector);
        // length >= 68, the custom error signature is ignored and only the message is bubbled up
        // vm.expectRevert("CustomData");
        vm.expectRevert(abi.encodeWithSelector(MockRevert.CustomErrorWithString.selector, "CustomData"));
        mockRevert.uniswapDelegateCall(data);
    }

    function test_uniswapDelegateCall_revertWithString() public {
        bytes memory data = abi.encodeWithSelector(MockRevert.revertWithString.selector);
        vm.expectRevert("Old school revert");
        mockRevert.uniswapDelegateCall(data);
    }
}
