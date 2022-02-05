// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum AccountRole {Estagiario, Regular,Gerente} 
enum permissionLevel {Baixo,Medio, Alto}
contract Permissao {
    uint256 public defaultDeltaDateTimeExpiration = 30 days;
    
    address owner;
   struct Funcionario {
        permissionLevel state;
        AccountRole role;
        uint256 dateTimeExpiration; 
    }
    mapping(address => Funcionario) public Account;
    constructor(){   
        Account[msg.sender] = Funcionario(permissionLevel.Alto ,
                AccountRole.Gerente,
                block.timestamp 

        );
        owner = msg.sender;
    }
    function add(address conta, uint256 funcao)public {
        if(Account[msg.sender].role == AccountRole.Gerente) {
            Account[conta] = Funcionario(permissionLevel.Baixo ,
                AccountRole(funcao),
                block.timestamp
        );
        }
    }

    function setMedio(address conta)public {
        if(Account[msg.sender].role == AccountRole.Gerente) {
            Account[conta].state = permissionLevel.Medio;
            Account[conta].dateTimeExpiration = block.timestamp + defaultDeltaDateTimeExpiration;
        }
    }

    function isMedio(address conta)public view returns(bool){
        return Account[conta].state >= permissionLevel.Medio && Account[conta].dateTimeExpiration > block.timestamp;
    }
    
}
