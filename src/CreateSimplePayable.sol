// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimplePayable {
    function main(uint256 dummy, bytes memory deploymentBytecode) external payable returns (address addr) {
        assembly {
            // your code here
            let bytesCodeSize := mload(deploymentBytecode)
            let bytesPtr := mload(add(deploymentBytecode,0x20)) 
            addr := create(callvalue(),bytesPtr,bytesCodeSize)
            if iszero(extcodesize(addr)){
                revert(0,0)
            }
        }
    }
}
