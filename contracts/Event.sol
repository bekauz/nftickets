//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import "./Ticket.sol";


contract Event {

    using Counters for Counters.Counter;
    Counters.Counter private _eventIds;

    address public ticketContract;
    Ticket ticket;

    struct EventInfo {
        string name;
        uint256 price;
        uint256 remainingSupply;
        address owner;
    }

    mapping(uint256 => EventInfo) public events;

    event NewEvent(uint indexed id, address indexed eventOwner);

    event SoldTicket(uint indexed id, address indexed ticketOwner);

    constructor(address _ticketContract) {
        ticketContract = _ticketContract;
        ticket = Ticket(ticketContract);
    }

    function getEventCount() external view returns (uint) {
        return _eventIds.current();
    }

    function createNewEvent(string calldata name, uint price, uint supply) external returns (uint) {
        uint256 newEventId = _eventIds.current();
        console.log("creating event #%d", newEventId);
        events[newEventId] = EventInfo(name, price, supply, msg.sender);
        emit NewEvent(newEventId, msg.sender);
        _eventIds.increment();
        return newEventId;
    }

    function buyTicketToEvent(uint eventId) external payable {

        uint256 ticketId = ticket.buyTicket(eventId, msg.sender);
        if (ticketId != 0) {
            events[eventId].remainingSupply--;
            emit SoldTicket(ticketId, msg.sender);
        } else {
            // TODO: throw
        }
    }

}