// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address[] memory emitters, bytes32[] memory ids, uint256[] memory nums) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.
            let size := mload(emitters)

            let emitterData := add(emitters,0x20)
            let idData := add(ids,0x20)
            let numsData := add(nums,0x20)

            for {let i:=0} lt(i,size) {i:=add(i,1)}{

                let emitter := mload(add(emitterData,mul(0x20,i)))
                let id := mload(add(idData,mul(0x20,i)))
                let num := mload(add(numsData,mul(0x20,i)))

                mstore(0x00,num)

                log3(0x00,0x20,0x044d482819499c9d5fde1245ce63873b1259fc52fc78651ccdcdf7392637d374,emitter,id)

            }

        }
    }
}
