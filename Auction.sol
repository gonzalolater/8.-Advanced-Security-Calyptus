// Unexpected Revert DoS
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Auction {
   address frontRunner;
   uint256 highestBid;
 
   function bid() public payable {
       require(msg.value > highestBid, "Need to be higher than highest bid");
       // Refund the old leader, if it fails then revert  
       require(payable(frontRunner).send(highestBid), "Failed to send Ether");
       frontRunner = msg.sender;
       highestBid = msg.value;
   }
}
