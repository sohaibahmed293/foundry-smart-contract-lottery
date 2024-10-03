// SPDX-License-Identifier4: MIT
pragma solidity ^0.8.19;

/**
 * @title A sample raffle contract
 * @author Sohaib Ahmad
 * @notice A contract for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle {
    // Errors
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    // contains addresses of all the participants
    // made payable because a winning address would be paid the lottery amount
    address payable[] private s_players;

    // Events
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        //        require(msg.value <= getEntranceFee(), "Not sent enough ETH!");
        //        require(msg.value <= getEntranceFee(), Raffle__SendMoreToEnterRaffle());
        if (msg.value <= getEntranceFee()) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    // Getter functions
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
