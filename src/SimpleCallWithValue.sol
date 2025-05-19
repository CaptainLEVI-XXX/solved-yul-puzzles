// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract SimpleCallWithValue {

    function main(address t) external payable {
        assembly {
            // your code here
            // call "t.foo()" while sending msg.value
            // hint: "foo()" has function selector 0xc2985578
            // hint: callvalue() returns the value of the current call
            let fooSelector := 0xc2985578
            mstore(0x00,fooSelector)
            let success:= call(gas(),t,callvalue(),0x1c,0x20,0x00,0x00)
       }
    }
}