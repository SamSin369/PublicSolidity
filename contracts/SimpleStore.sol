pragma solidity ^0.8.8;

contract SimpleStore {
    // boolearn, unit, int, address,address, bytes

    uint256 public favoriteNumber;


    
    uint256 public favoritNumbersList;

    People[] public people;

    mapping(string => uint256) public nameToFavoriteNumber;


    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber)  public virtual {
        favoriteNumber = _favoriteNumber;
        
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public virtual {

        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}