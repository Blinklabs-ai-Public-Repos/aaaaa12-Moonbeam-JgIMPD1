// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Multicall.sol";

/**
 * @title MultisendToken
 * @dev ERC20 token with multisend capability and inheriting from OpenZeppelin Multicall
 */
contract MultisendToken is ERC20, Multicall {
    uint256 public immutable MAX_SUPPLY;

    /**
     * @dev Constructor to initialize the token
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param maxSupply_ The maximum supply of the token
     */
    constructor(string memory name_, string memory symbol_, uint256 maxSupply_) ERC20(name_, symbol_) {
        MAX_SUPPLY = maxSupply_;
        _mint(msg.sender, maxSupply_);
    }

    /**
     * @dev Multisend function to send tokens to multiple addresses in one transaction
     * @param recipients Array of recipient addresses
     * @param amounts Array of amounts to send to each recipient
     * @notice The length of recipients and amounts arrays must be equal
     */
    function multisend(address[] memory recipients, uint256[] memory amounts) external {
        require(recipients.length == amounts.length, "Recipients and amounts arrays must have the same length");
        
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < amounts.length; i++) {
            totalAmount += amounts[i];
        }
        
        require(balanceOf(msg.sender) >= totalAmount, "Insufficient balance for multisend");

        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(msg.sender, recipients[i], amounts[i]);
        }
    }

    /**
     * @dev Override of the _mint function to enforce the max supply limit
     * @param account The account to mint tokens to
     * @param amount The amount of tokens to mint
     */
    function _mint(address account, uint256 amount) internal virtual override {
        require(totalSupply() + amount <= MAX_SUPPLY, "Cannot mint more than max supply");
        super._mint(account, amount);
    }
}