// SPDS-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStore.sol";

contract StorageFactory {

    SimpleStore[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStore simpleStorage = new SimpleStore();
        simpleStorageArray.push(simpleStorage);

    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //Address
        //ABI - Application Binary Interface
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
        SimpleStore simpleStorage = simpleStorageArray[_simpleStorageIndex];
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStore simpleStorageArray = simpleStorageArray[_simpleStorageIndex];
    }
}