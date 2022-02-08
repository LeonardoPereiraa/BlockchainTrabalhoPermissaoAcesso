// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum AccountRole {Estagiario, Regular,Gerente}
enum permissionLevel {Baixo,Medio, Alto}
contract Permissao {

    uint256 public defaultDeltaDateTimeExpiration = 30 days;
    address public owner;
    event solicitarPermissao(address solicitante, address paraConta, permissionLevel nivel );
    struct Funcionario {
        permissionLevel state;
        AccountRole role;
        uint256 dateTimeExpiration;
    }
    mapping(address => Funcionario) public Account;
    constructor(address _ower){
        Account[msg.sender] = Funcionario(permissionLevel.Alto ,
                AccountRole.Gerente,
                block.timestamp

        );
        owner = _ower;
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

    function setAlto(address conta) public returns(bool) {

        if (msg.sender == owner) {

            Account[conta].state = permissionLevel.Alto;
            Account[conta].dateTimeExpiration = block.timestamp + defaultDeltaDateTimeExpiration;
            return true;

        } else { return false; }

    }

    function isAlto(address conta) public view returns(bool) {

        if (Account[conta].state == permissionLevel.Alto
            && Account[conta].dateTimeExpiration > block.timestamp) {

            return true;

        } else { return false; }

    }
    function setBaixo(address conta)public {
        if(Account[msg.sender].role == AccountRole.Gerente) {
            Account[conta].state = permissionLevel.Baixo;
            Account[conta].dateTimeExpiration = block.timestamp ;
        }
    }
    function solicitarPermissaoAlta(address conta) public{
        if(Account[msg.sender].role == AccountRole.Gerente){
            emit solicitarPermissao(msg.sender,conta,permissionLevel.Alto);
        }

    }


}
