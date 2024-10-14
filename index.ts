import { parseAbi } from "viem";
import { waitForTransactionReceipt, writeContract } from "@wagmi/core";
import { createConfig, http } from "wagmi";
import { baseSepolia } from "wagmi/chains";
import { privateKeyToAccount } from "viem/accounts";

const VAULT_ADDRESS = "0xf639c473bdab793fa24ea5de0f907cac6eaa941b";
const VAULT_ABI = [
  "function deposit()",
  "function withdraw()",
  "error AmountTooLow()",
];

const PRIVATE_KEY =
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"; // anvil private key
const BASE_SEPOLIA_RPC = "http://localhost:8545";

export const config = createConfig({
  chains: [baseSepolia],
  multiInjectedProviderDiscovery: true,
  transports: {
    [baseSepolia.id]: http(BASE_SEPOLIA_RPC),
  },
});

async function main() {
  const account = privateKeyToAccount(PRIVATE_KEY);

  const txHash = await writeContract(config, {
    abi: parseAbi(VAULT_ABI),
    address: VAULT_ADDRESS,
    functionName: "deposit",
    account,
    // sending 1 wei to receive the AmountTooLow error
    value: 1n, // 1 wei

    // setting gas to 1_000_000 and __mode to "prepared" to avoid any simulations or estimation
    __mode: "prepared",
    gas: 1_000_000n,
  });

  console.log("txHash", txHash);

  const receipt = await waitForTransactionReceipt(config, {
    hash: txHash,
  });

  // expecting transaction to be reverted with correct reason
  console.log("receipt", receipt);
}

main().catch(console.error);
