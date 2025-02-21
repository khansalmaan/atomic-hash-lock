// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HashTimeLock {
    address payable public sender;
    address payable public recipient;
    bytes32 public hashLock;
    uint256 public expiration;

    bool public isWithdrawn;
    bool public isRefunded;

    event Deposited(address sender, uint256 amount, bytes32 hashLock, uint256 expiration);
    event Withdrawn(address recipient, uint256 amount, string preimage);
    event Refunded(address sender, uint256 amount);

    modifier onlyRecipient() {
        require(msg.sender == recipient, "Only recipient can withdraw");
        _;
    }

    modifier onlySender() {
        require(msg.sender == sender, "Only sender can refund");
        _;
    }

    modifier notExpired() {
        require(block.timestamp < expiration, "Lock time expired");
        _;
    }

    modifier onlyExpired() {
        require(block.timestamp >= expiration, "Not yet expired");
        _;
    }

    constructor(address payable _recipient, bytes32 _hashLock, uint256 _duration) payable {
        require(msg.value > 0, "Must send ETH");
        require(_duration > 0, "Duration must be positive");

        sender = payable(msg.sender);
        recipient = _recipient;
        hashLock = _hashLock;
        expiration = block.timestamp + _duration;

        emit Deposited(msg.sender, msg.value, _hashLock, expiration);
    }

    function withdraw(string memory _preimage) external onlyRecipient notExpired {
        require(keccak256(abi.encodePacked(_preimage)) == hashLock, "Invalid preimage");
        require(!isWithdrawn, "Already withdrawn");

        isWithdrawn = true;
        recipient.transfer(address(this).balance);

        emit Withdrawn(recipient, address(this).balance, _preimage);
    }

    function refund() external onlySender onlyExpired {
        require(!isWithdrawn, "Already withdrawn");
        require(!isRefunded, "Already refunded");

        isRefunded = true;
        sender.transfer(address(this).balance);

        emit Refunded(sender, address(this).balance);
    }
}
