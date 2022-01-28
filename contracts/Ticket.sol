//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Ticket {

    using Counters for Counters.Counter;
    Counters.Counter private _soldTickets;

    address public eventAddress;

    constructor(address _event) {
        eventAddress = _event;
    }

    function buyTicket(uint256 eventId, address buyer) external view returns (uint256) {
        
        return _soldTickets.current();
    }
}