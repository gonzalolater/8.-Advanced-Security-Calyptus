//struct Payee {
//       address addr;
//       uint256 value;
//   }
// 
//   Payee[] payees;
//   uint256 nextPayeeIndex;
// 
//   function payOut() {
//       uint256 i = nextPayeeIndex;
//       while (i < payees.length && msg.gas > 200000) {
//      payees[i].addr.send(payees[i].value);
//      i++;
//       }
//       nextPayeeIndex = i;
// }  
contract Auction {
   address frontRunner;
   uint256 highestBid;
   mapping(address => uint) public balances;
  function bid() public payable {
     require(msg.value > highestBid, "Need to be higher than highest bid");
     // update previous bidder info
     balances[frontRunner] += highestBid;
     // update new bidder
     frontRunner = msg.sender;
     highestBid = msg.value;
  }
  function withdraw() public nonReentrant {
       require(msg.sender != frontRunner, "Current frontRunner cannot withdraw");
       uint amount = balances[msg.sender];
       balances[msg.sender] = 0;
       (bool sent, ) = msg.sender.call{value: amount}("");
       require(sent, "Failed to send Ether");
   }
}
