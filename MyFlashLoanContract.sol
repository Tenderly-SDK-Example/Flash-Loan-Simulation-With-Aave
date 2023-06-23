pragma solidity ^0.6.12;
import "path_to_aave/FlashLoanReceiverBase.sol";
import "path_to_aave/ILendingPoolAddressesProvider.sol";

contract MyFlashLoanContract is FlashLoanReceiverBase {
    constructor(address _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}
    
    function executeOperation(
        address _reserve,
        uint _amount,
        uint _fee,
        bytes memory _params
    ) external override {
        // Logic for what happens during the flash loan
        // e.g., arbitrage, collateral swap, liquidation

        // Repay the loan
        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
    }
}
