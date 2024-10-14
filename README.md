# `@wagmi/core` Bug in `waitForTransactionReceipt` 🐛

This repository demonstrates a proof of concept (PoC) for a bug found in the `@wagmi/core` library, specifically within the `waitForTransactionReceipt` function.

### Bug Description

The issue occurs when providing arguments to bypass simulation or gas estimation. In this case, the function fails to pass the `data` argument to the underlying `eth_call` function. This omission can lead to unexpected errors being thrown, instead of the expected transaction results.

### Reproducing the Bug

To reproduce this issue, ensure you have both `anvil` and `bun` installed. Follow the steps below:

```
# install all dependencies
bun install

# run anvil
anvil --fork-url https://sepolia.base.org --block-time 5

# execute the script
bun index.ts

# This script executing deposit() function from the contract from src/SimpleVault.sol
```

### Expected vs. Actual Behavior

* Expected behavior: The script should throw the error `AmountTooLow()`.
* Actual behavior: The script throws a no receive error, highlighting the bug in the waitForTransactionReceipt function.
