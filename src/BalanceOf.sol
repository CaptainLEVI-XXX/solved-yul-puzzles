// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BalanceOf {
    // emit these
    function main(address token) external view returns (uint256) {
        assembly {
            mstore(0x00,0x70a08231)
            mstore(0x20,address())
            let success := staticcall(gas(),token,28,0x40,0x00,0x00)
            if iszero(success){
                revert(0x00,0x00)
            }
            returndatacopy(0,0,returndatasize())
            return(0x00,returndatasize())
       }
    }
}

