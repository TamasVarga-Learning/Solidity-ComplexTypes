// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract ComplexTypeExample {

    // constant
    uint256 constant maxNumberOfUsers = 3;

    // immutable
    address public immutable owner = msg.sender;

    // storage arrays
    uint256[] public numbers; // dynmic length array
    address[maxNumberOfUsers] private users; // fixed length array
    uint8 userCount = 0;

    // byte[] or bytes and string
    // elements in memory arrays in Solidity always occupy multiples of 32 bytes -> byte[] will waste 31 bytes for each element
    // string is a dynamic array of UTF-8 data
    // use the value types bytes1 to bytes32 if the number of bytes of the string can be limited, since it’s much cheaper

    // struct
    struct Donation {
      uint256 value;
      uint256 date;
    }

    // mapping - any value can be set or retrieved in one move with the key
    mapping(address => Donation[]) donations;

    // add item to dynamic length array
    function addNumber(uint256 number) external {
        numbers.push(number);
    }

    // add item to fixed length array
    function addUser(address user) external {
        require(userCount < maxNumberOfUsers, "Only 3 users are allowed");

        users[userCount] = user;
        userCount++;
    }

    // memory arrays
    function memoryArrays() external view {
        // fixed sized memory array
        uint256[10] memory memoryNumbers;
        memoryNumbers[0] = 134;
        memoryNumbers[1] = 22;
        
        // dynamically sized memory arrays can’t be resized -> can’t call push() and pop() methods
        // the size of the array must be calculated in advance
        uint256 length = memoryNumbers.length;
        address[] memory memoryUsers = new address[](length);
        memoryUsers[0] = msg.sender;
    }

    // mapping and struct array
    function donate() external payable {
        Donation memory donation = Donation({
            value: msg.value,
            date: 123456
        });

        donations[msg.sender].push(donation);
    }
}