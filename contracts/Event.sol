//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Event {

    using Counters for Counters.Counter;
    Counters.Counter private _eventIds;

    address public ticketContract;

    struct EventInfo {
        string name;
        uint256 price;
        uint256 remainingSupply;
        address owner;
    }

    mapping(uint256 => EventInfo) public events;

    event NewEvent(uint indexed id, address indexed eventOwner);

    event SoldTicket(uint indexed id, address indexed ticketOwner);

    constructor(/*address _ticketContract*/) public {
        // ticketContract = _ticketContract;
    }

    function createNewEvent(string calldata name, uint price, uint supply) external returns (uint) {
        uint256 newEventId = _eventIds.current();
        console.log("creating event with id %d", newEventId);
        events[newEventId] = EventInfo(name, price, supply, msg.sender);
        emit NewEvent(newEventId, msg.sender);
        _eventIds.increment();
        return newEventId;
    } 
}