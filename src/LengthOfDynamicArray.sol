// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract LengthOfDynamicArray {
    function main(uint256[] memory x) external view returns (uint256) {
        assembly {
            let ptr := mload(x)
            mstore(0x00,ptr)
            return(0x00,0x20)
        }
    }
}
