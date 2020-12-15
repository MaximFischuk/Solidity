pragma solidity >=0.7.0 <0.8.0;

import  "github.com/smartcontractkit/chainlink/evm-contracts/src/v0.6/ChainlinkClient.sol";

contract ChainlinkExample is ChainlinkClient {
    uint256 public currentPrice;
    address public owner;
    address public ORACLE_ADDRESS = 0xAA1DC356dc4B18f30C347798FD5379F3D77ABC5b;
    string constant JOBID = "9cc0c77e8e6e4f348ef5ba03c636f1f7";
    uint256 constant private ORACLE_PAYMENT = 100000000000000000;
    
    constructor() public {
        setPublicChainlinkToken()
        owner = msg.sender;
    }

function requestEthereumPrice(bytes32) public onlyOwner{
    Chainlink.Request memory req = buildChainlinkRequest(stringToBytes32(9cc0c77e8e6e4f348ef5ba03c636f1f7), address(this), this.fulfill.selector);
    req.add("get", "http://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD");
    req.add("path", "USD");
    req.addInt("times", 100);
    sendChainlinkRequestTo(0xAA1DC356dc4B18f30C347798FD5379F3D77ABC5b, req, 100000000000000000);
}

function fulfill(bytes32 _requestId, uint256, _price) public recordChainlinkFulfillment(_requestId) {
    currentPrice = _price;
}    
    
modifier onlyOwner() {
    require(msg.sender ==owner);
    _;
}
