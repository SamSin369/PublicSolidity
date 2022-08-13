pragma solidity ^0.8.0;


import "./SimpleStore.sol";

contract ExtraStorage is SimpleStore {


    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}