// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Epargne is Ownable {

    uint numDepot;
    mapping(uint => uint) histoDepots;
    uint whenWithdrawIsPossble;

    // Le propriétaire du contrat peut déposer des ETH sur le smart contrat 
    function deposit() public payable onlyOwner {
        numDepot++;
        // Historique des depots
        histoDepots[numDepot] = msg.value;
        // Le retrait sera possible passé un certain délai
        if(whenWithdrawIsPossble == 0){
            whenWithdrawIsPossble = block.timestamp + 12 weeks; // ou 1 hours, 1 days, 1 weeks ... 
        }
    }

    // Le propriétaire du contrat peut récupérer tous ses ETH (contenus dans le contrat) une fois les 12 semaines passées
    function withdraw() public onlyOwner {
        require(block.timestamp >= whenWithdrawIsPossble, "Trop tot pour retirer");
        // Renvoie la balance du contrat vers l'adresse de la personne qui a éxécuté la fonction 
        (bool sent, ) = payable(msg.sender).call{value:address(this).balance}("");
        require (sent, "transfert en echec");
    }

    // Le propriétaire du contrat peut récupérer une partie de ses ETH (contenus dans le contrat)
    function withdraw(uint _amout) public onlyOwner {
        require(_amout <= address(this).balance, "Balance insuffisante sur le smart contrat");
        // Renvoie la balance du contrat vers l'adresse de la personne qui a été la fonction 
        (bool sent, ) = payable(msg.sender).call{value:_amout}("");
        require (sent, "transfert en echec");
    }
}
