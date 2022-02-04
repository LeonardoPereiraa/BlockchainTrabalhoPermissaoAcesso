// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum AccountRole {Estagiario, Regular,Gerente} 
enum permissionLevel {Baixo,Medio, Alto}
contract Permissao {
    uint256 public defaultDeltaDateTimeExpiration = 365 days;
    
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
    
}
