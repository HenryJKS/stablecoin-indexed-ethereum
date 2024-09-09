// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0

// stablecoin indexed to ETH
// 1 ETH equivalent n HTC

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract HJKStableCoin is ERC20, Ownable {
    // TokenTimelock public timeLock;

    AggregatorV3Interface internal dataFeed;

    mapping(address => uint256) public collateral;

    // uint256 initialMint = 1000 * 10 ** decimals();

    event Mint(
        address indexed account,
        uint ethDeposit,
        uint amountCollateral,
        uint time
    );
    event Burn(
        address indexed account,
        uint ethWithdraw,
        uint amountCollateral,
        uint time
    );

    constructor(
        address initialOwner
    ) ERC20("HJKStableCoin", "HSC") Ownable(initialOwner) {
        // _mint(address(this), 10 * 10 ** decimals());
        // timeLock = new TokenTimelock(
        //     this,
        //     initialOwner,
        //     block.timestamp + 365 days
        // );

        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306 // Address pair ETH/USD
        );
    }

    function renounceOwnership() public virtual override {
        revert("Not allowed");
    }

    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        (, int256 answer, , , ) = dataFeed.latestRoundData();

        return answer;
    }

    function mintStableCoin() external payable {
        require(msg.value > 0, "Deposit ETH required");

        int256 ethPrice = getChainlinkDataFeedLatestAnswer();

        require(ethPrice > 0, "Price feed error");

        uint256 stableCoinAmount = (msg.value * uint256(ethPrice)) / 1e8;

        collateral[msg.sender] += msg.value;

        _mint(msg.sender, stableCoinAmount);

        emit Mint(msg.sender, msg.value, stableCoinAmount, block.timestamp);
    }

    function burnStableCoin(uint256 stableCointAmount) external {
        require(
            balanceOf(msg.sender) >= stableCointAmount,
            "Insufficient Balance"
        );

        int256 ethPrice = getChainlinkDataFeedLatestAnswer();
        require(ethPrice > 0, "Price feed error");

        uint256 ethAmount = (stableCointAmount * 1e8) / uint256(ethPrice);

        require(collateral[msg.sender] >= ethAmount, "Insufficient collateral");

        _burn(msg.sender, stableCointAmount);

        collateral[msg.sender] -= ethAmount;

        payable(msg.sender).transfer(ethAmount);

        emit Burn(msg.sender, ethAmount, stableCointAmount, block.timestamp);
    }

    // function testBalanceOf() public view returns (uint256) {
    //     return balanceOf(msg.sender) / 1e8;
    // }

    // function testCollateral() public view returns (uint256) {
    //     return collateral[msg.sender] / 1 ether;
    // }
}
