// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';

// Contract definition
contract NewPairMonitor {
    // State variables
    address public factoryAddress; // Address of the Uniswap V2 factory contract
    address[] public pairs; // Array to store addresses of newly created pairs

    // Constructor function
    constructor(address _factoryAddress) {
        factoryAddress = _factoryAddress;
    }

    // Function to start monitoring for new pairs
    function startMonitoring() external {
        // Instantiate the Uniswap Factory Contract
        IUniswapV2Factory factoryContract = IUniswapV2Factory(factoryAddress);

        // Listen for PairCreated events
        factoryContract.onPairCreated(address(this), _handlePairCreated);
    }

    // Event handler for PairCreated events
    function _handlePairCreated(address _pair, address _token0, address _token1) internal {
        // Store the address of the new pair
        pairs.push(_pair);
    }

    // Function to get the count of new pairs
    function getNewPairsCount() external view returns (uint256) {
        return pairs.length;
    }

    // Function to get the address of a new pair by index
    function getNewPairAddress(uint256 index) external view returns (address) {
        require(index < pairs.length, "Index out of bounds");
        return pairs[index];
    }
}
// In this Solidity code:

// The NewPairMonitor contract is defined with a constructor that sets the address of the Uniswap V2 factory contract.
// There's a startMonitoring function to begin listening for PairCreated events emitted by the factory contract.
// The _handlePairCreated function serves as the event handler for PairCreated events. It stores the addresses of newly created pairs in an array.
// Two getter functions, getNewPairsCount and getNewPairAddress, allow retrieving information about the newly created pairs.
// Note: Solidity doesn't support event listeners like JavaScript, so the code structure is different. Additionally, the code assumes you have the ABIs for the Uniswap factory and pair contracts (uniswap-v2-factory-abi.sol and uniswap-v2-pair-abi.sol, respectively). Make sure to replace these with the actual ABIs.