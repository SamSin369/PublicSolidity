pragma solidity ^0.8.0;

// Get Funds from users
//Withdraw funds
// Set a minimum funding value is USD

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    constructor() {
        i_owner = msg.sender;

    }

    function fund() public payable {
        
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Did not send enough moneys");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function withdraw() public {
        
        /* starting,index, ending index, step amount*/
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex +1) {

            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array

        funders = new address[](0);

        //transfer
        //send
        //call
        // must type cast an address to payable
        // payable(msg.sender).transfer(address(this).balance);
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
        // withdraw the funds

    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not the owner");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }
     receive() external payable {
         fund();
     }

     fallback() external payable {
         fund();
     }

    // function withdraw() {

    // }
}