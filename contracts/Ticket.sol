//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract Ticket is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _soldTickets;

    address public eventAddress;

    struct TicketInfo {
        uint256 eventId;
    }

    mapping(uint256 => address) internal ticketOwners;
    mapping(uint256 => TicketInfo) internal tickets;

    constructor(address _event)
        ERC721("NFTicket", "TICKET") {
        eventAddress = _event;
    }

    function buyTicket(uint256 eventId, address buyer) external returns (uint256) {
        _soldTickets.increment();
        uint256 ticketId = _soldTickets.current();
        
        tickets[ticketId] = TicketInfo(eventId);
        ticketOwners[ticketId] = buyer;

        _mint(buyer, ticketId);

        return ticketId;
    }
}