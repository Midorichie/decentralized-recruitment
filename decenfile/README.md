# DecenFile: Decentralized Recruitment Platform

A blockchain-based recruitment platform that allows employers to post jobs and applicants to apply with their credentials, all in a decentralized manner using Stacks blockchain and Clarity smart contracts.

## Overview

DecenFile leverages blockchain technology to create a transparent, secure, and efficient recruitment ecosystem. The platform connects employers and job seekers without centralized intermediaries, using smart contracts to manage job postings, applications, and matching algorithms.

### Key Features

- **Decentralized Job Posting**: Employers can post job opportunities with detailed descriptions and required skills.
- **Secure Application Process**: Applicants can apply to jobs with their credentials stored on IPFS (via CIDs).
- **Skill-Based Matching**: Smart contract automatically calculates match scores between applicants and job postings.
- **Transparent Process**: All interactions are recorded on the blockchain, ensuring transparency and immutability.

## Smart Contracts

The project consists of three main smart contracts:

1. **jobs.clar**: Manages job postings by employers, including job details and required skills.
2. **applicants.clar**: Handles job applications and applicant profiles.
3. **matching.clar**: Implements the algorithm to calculate matches between applicants and jobs.

## Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet): Clarity development environment
- [Stacks CLI](https://docs.stacks.co/stacks.js/getting-started): For interacting with the Stacks blockchain

### Installation

1. Clone the repository:
```bash
git clone https://github.com/midorichie/decenfile.git
cd decenfile
```

2. Install dependencies:
```bash
npm install
```

3. Initialize Clarinet (if not already done):
```bash
clarinet new
```

### Development

To test the smart contracts locally:

```bash
clarinet test
```

To deploy to the Stacks testnet:

```bash
clarinet deploy --testnet
```

## Contract Usage

### Posting a Job

```clarity
(post-job u1 "Software Developer" "QmXyZ123..." (list "blockchain" "smart-contracts" "clarity"))
```

### Applying for a Job

```clarity
(apply-job u1 u1 "QmAbC456...")
```

### Calculating a Match

```clarity
(calculate-match u1 u1)
```

## Architecture

- **Smart Contracts**: Written in Clarity, deployed on the Stacks blockchain
- **Resume Storage**: Resume content identifiers (CIDs) point to documents stored on IPFS
- **Job Descriptions**: Also stored on IPFS with CIDs referenced in the smart contracts

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Your Name - [@hamyak007](https://twitter.com/hamyak007) - hamsohood@gmail.com.com

Project Link: [https://github.com/yourusername/decenfile](https://github.com/midorichie/decenfile)
