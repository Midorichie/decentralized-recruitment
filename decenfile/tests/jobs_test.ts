import { Clarinet, Tx, Chain, Account } from "clarinet";
describe("jobs contract tests", () => {
  Clarinet.test({
    name: "post and query job success",
    async fn(chain: Chain, accounts: Map<string, Account>) {
      const deployer = accounts.get("deployer")!;
      let block = chain.mineBlock([
        Tx.contractCall("decentralized-recruitment.jobs", "post-job", ["u1", `"Title"`, `"Qm..."`, `("skill1" "skill2")`], deployer.address)
      ]);
      block.receipts[0].result.expectOk().expectUint(1);
    }
  });
});
