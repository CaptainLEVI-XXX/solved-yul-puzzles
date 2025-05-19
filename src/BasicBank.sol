// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BasicBank {
    // emit these
    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    error InsufficientBalance();

    mapping(address => uint256) public balances;

    function deposit() external payable {
        bytes32 depositSelector = Deposit.selector;
        uint256 slot;
        assembly {
            // emit Deposit(msg.sender, msg.value)
            mstore(0x00,callvalue())
            log2(0x00,0x20,depositSelector,caller())
            // increment the balance of the msg.sender by msg.value
            slot := balances.slot
        }
        bytes32 location = keccak256(abi.encode(msg.sender,slot));
        assembly{
            sstore(location,add(sload(location),callvalue()))

        }
    }

    function withdraw(uint256 amount) external returns (uint256 bal) {
        bytes32 withdrawSelector = Withdraw.selector;
        bytes4 insufficientBalanceSelector = InsufficientBalance.selector;
        uint256 slot;
        assembly {
            // emit Withdraw(msg.sender, amount)
            mstore(0x00,amount)
            log2(0x00,0x20,withdrawSelector,caller())
            slot := balances.slot
        }
        bytes32 location = keccak256(abi.encode(msg.sender,slot));
        // if the balance is less than amount, revert InsufficientBalance()
        assembly{
            bal := sload(location)
            if lt(bal,amount){
                mstore(0x00,insufficientBalanceSelector)
                revert(0x00,0x04)
            }
            sstore(location,sub(bal,amount))
            bal:=sload(location)
            let success := call(gas(),caller(),amount,0x00,0x00,0x00,0x00)


        }
            
            // decrement the balance of the msg.sender by amount
            // send the amount to the msg.sender
        }
    }

