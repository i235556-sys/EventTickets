// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// MG3012 Assignment 2
// Okasha Saeed (23i-5556)
// EventTickets: book a seat for an event by paying in SepoliaETH.
// Each wallet can hold one ticket and seats are limited.

contract EventTickets {

    address public owner;

    string public eventName = "FinTech Night 2026";
    string public venue = "FAST NUCES Islamabad, Main Auditorium";
    string public eventDate = "20 December 2026, 7:00 PM";

    uint public ticketPrice = 0.001 ether;
    uint public totalSeats = 50;
    uint public ticketsSold;

    mapping(address => uint) private seatOf;   // 0 means no ticket
    address[] private attendees;

    event TicketBought(address indexed buyer, uint seatNo, uint amountPaid);
    event FundsWithdrawn(address indexed owner, uint amount);

    constructor() {
        owner = msg.sender;
    }

    // write: buy one ticket, must send exactly the ticket price
    function buyTicket() external payable {
        require(ticketsSold < totalSeats, "Sold out");
        require(seatOf[msg.sender] == 0, "You already have a ticket");
        require(msg.value == ticketPrice, "Send exactly the ticket price");

        ticketsSold += 1;
        seatOf[msg.sender] = ticketsSold;
        attendees.push(msg.sender);

        emit TicketBought(msg.sender, ticketsSold, msg.value);
    }

    // write: organiser takes out the money collected from ticket sales
    function withdrawFunds() external {
        require(msg.sender == owner, "Only the organiser can withdraw");
        uint amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw");

        (bool sent, ) = payable(owner).call{value: amount}("");
        require(sent, "Transfer failed");

        emit FundsWithdrawn(owner, amount);
    }

    // read: all event details in one call
    function getEventDetails() external view returns (
        string memory, string memory, string memory, uint, uint, uint
    ) {
        return (eventName, venue, eventDate, ticketPrice, ticketsSold, totalSeats);
    }

    // read: seat number of a wallet (0 if it has no ticket)
    function getTicket(address _user) external view returns (uint) {
        return seatOf[_user];
    }

    // read: list of everyone who booked
    function getAttendees() external view returns (address[] memory) {
        return attendees;
    }
}
