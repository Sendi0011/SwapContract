import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("TokenSwapBuild", (m) => {
  const counter = m.contract("TokenSwap");

  m.call(counter, "incBy", [5n]);

  return { counter };
});
