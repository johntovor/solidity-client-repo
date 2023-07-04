// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

error NotOwner();

contract ClientStorage {
    address internal immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    struct Client {
        string fullName;
        string email;
        string phoneNumber;
        uint256 age;
        string location;
        address bep20Address;
    }

    Client[] public client;

    mapping(string => address) public nameToAddress;

    function addClient(
        string memory _fullName,
        string memory _email,
        string memory _phoneNumber,
        uint256 _age,
        string memory _location,
        address _bep20Address
    ) public isOwner {
        Client memory newClient = Client({
            fullName: _fullName,
            email: _email,
            phoneNumber: _phoneNumber,
            age: _age,
            location: _location,
            bep20Address: _bep20Address
        });
        client.push(newClient);
        nameToAddress[_fullName] = _bep20Address;
    }

    function retrieveClients() public view returns (Client[] memory) {
        return client;
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    modifier isOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
