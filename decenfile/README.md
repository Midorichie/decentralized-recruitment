# Decentralized Recruitment & Job Matching

## Setup
1. Install dependencies: `npm install -g @blockstack/clarinet typescript`
2. Clone repo and `cd decentralized-recruitment`
3. Run tests: `clarinet test`
4. Deploy: `npm run deploy`

## Structure
- **contracts/**: Clarity contracts
- **tests/**: unit tests
- **scripts/**: deployment helpers

## Workflow
1. Employers post jobs using `post-job`
2. Applicants apply via `apply-job`
3. Match scored off-chain using events and indexing
