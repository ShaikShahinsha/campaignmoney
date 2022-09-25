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
        mapping(address => bool) totalapprovers;
    }

    Requests[] public requests;

    constructor(uint minmamount){
        manager = msg.sender;
        mincontribution = minmamount;
    }

    function contribute() public payable{
        require(msg.value > mincontribution);

        contributors[msg.sender] = true;
        contributorsCount++;
    }

    function  createRequest(string memory description, uint val, address receiver) public _onlyManager{
        Requests storage newRequest = requests.push();
        newRequest.desc = description;
        newRequest.value = val;
        newRequest.receipient = receiver;
        newRequest.complete = false;
        newRequest.contributor_approval_count = 0;

     }

     function approveRequest(uint index) public {
        Requests storage req = requests[index];
        require(contributors[msg.sender]);
        require(!req.totalapprovers[msg.sender]);
        req.totalapprovers[msg.sender] = true;
        req.contributor_approval_count++;
     }

    function finalizeRequest(uint index) public _onlyManger{
        Request storage reqs = requests[index];
        require(!reqs.complete);
        require(reqs.contributor_approval_count > (totalapprovers / 2));

        payable(request.recipient).transfer(request.value);

        reqs.complete = true;

    }  

    function getSummary() public view returns (
      uint, uint, uint, uint, address
      ) {
        return (
          minimumContribution,
          address(this).balance,
          requests.length,
          approversCount,
          manager
        );
    }   

        function getRequestsCount() public view returns (uint) {
        return requests.length;
    }
    
     
    modifier _onlyManager(){
        require(msg.sender == manager);
        _;
    }

}