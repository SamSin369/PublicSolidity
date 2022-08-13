contract Descicion {


uint stakingWallet =10;


function airDrop() public view returns(uint) {

    if (stakingWallet == 10) {
       return stakingWallet + 10;
    }  
}


// function getChar() public view returns(uint) {
//     return greetings.length;
// }
string me = "asdfasdf";

function doColors() external returns(string memory param) {
    
     bytes memory meBytes = bytes(param);

    return string(meBytes);

}





}