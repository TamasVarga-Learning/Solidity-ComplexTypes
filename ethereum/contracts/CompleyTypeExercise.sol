// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract Crud {

    struct User{
        uint256 id;
        string name;
    }

    User[] public users;
    uint256 public userId = 1;

    function add(string memory userName) public {
        User memory user = User({
            id: userId,
            name: userName
        });

        users.push(user);
        userId++;
    }

    function read(uint256 id) public view returns(User memory) {
        uint index = getIndexById(id);
        return users[index];
    }

    function update(uint id, string memory userName) public {
        uint index = getIndexById(id);
        users[index].name = userName;
    }

    function remove(uint id) public {
        uint index = getIndexById(id);
        delete users[index];
    }
    
    function getIndexById(uint id) private view returns (uint) {
        uint index = id - 1;

        if (id > users.length || users[index].id == 0) {
            revert("User not found");
        }

        return index;
    }
}