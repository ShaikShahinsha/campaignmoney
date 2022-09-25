// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Campaignraiser{
    
    
    uint public mincontribution;
    uint public contributorsCount;
    address public manager;
    mapping ( address => bool ) contributors;
    
    struct Requests{
        string desc;
        uint value;
        address receipient;
        bool complete;
        uint contributor_approval_count;
        mapping(address => bool) totalapprovals;
        

    }


    constructor( ){
        manager = msg.sender;
    }



}