// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
/*

 * @title StableZcoin
 * @author liujingze
 * Collaternal : Exogenous (ETH&BTC)
 * Minting Algorithm
 * Relative Stability
 */
contract StableZcoin is ERC20Burnable, Ownable {

    error StableZcoin_MustMorethanZero();
    error StableZcoin_BurnMorethanBalance();
    error StableZcoin_MintToZeroAddress();
    
    constructor() ERC20("StableZcoin", "SZC")  Ownable(msg.sender) {
        _mint(msg.sender, 1000000000 * 10 ** 18);
    }
    
    function burn(uint256 _amount) override public onlyOwner {
        
        uint256 balance = balanceOf(msg.sender);

        if (_amount <= 0) {
            revert StableZcoin_MustMorethanZero();
        }
        if (_amount > balance) {
            revert StableZcoin_BurnMorethanBalance();
        }
        
        super.burn(_amount);
        
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        if (address(0) == _to) {
            revert StableZcoin_MintToZeroAddress();
        }
        if (_amount <= 0) {
            revert StableZcoin_MustMorethanZero();
        }
        _mint(_to, _amount);
        
        return true;

        
    }
}
