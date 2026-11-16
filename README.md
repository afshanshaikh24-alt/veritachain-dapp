VeritaChain: Ethereum Academic Credential Verification DApp

The Problem We Are Solving
Traditional academic certificate and document verification is slow, centralized, and prone to fraud. Employers, universities, and institutions rely on manual verification processes, physical stamps, or centralized databases that can be tampered with, hacked, or taken offline.

VeritaChain solves this by establishing a decentralized, trustless, and tamper-proof verification pipeline. Instead of trusting a single centralized server, the system anchors cryptographic fingerprints (SHA-256 hashes) and student metadata directly onto the Ethereum blockchain, ensuring permanent record integrity and instant global verification.

What We Are Using (Tech Stack)

Smart Contract (Backend): Solidity ^0.8.20 featuring struct mappings, role-based access control (onlyIssuer), and on-chain revocation states.

Blockchain Network: Ethereum Sepolia Testnet (EVM-compatible).

Web3 Integration: Ethers.js v6 (ethers.umd.min.js) for wallet connections and smart contract interaction.

Frontend: HTML5, responsive CSS3 dark theme, and JavaScript (ES6+).

Local Cryptography: Browser-native Web Crypto API (crypto.subtle.digest) to compute SHA-256 file hashes locally, ensuring private documents never leave the user's browser.

Wallet Provider: MetaMask Browser Extension.

How to Run It

Prerequisites

Visual Studio Code installed on your machine.

The Live Server extension installed in VS Code.

The MetaMask browser extension installed in Google Chrome, configured with a small amount of free Sepolia test ETH.

Steps to Launch Locally

Clone or download the project workspace folder.

Open the project folder inside Visual Studio Code.

Right-click the index.html file and select Open with Live Server. This will host the DApp locally in your browser.

Click the Connect button in the top-right corner of the webpage to link your MetaMask wallet to the Sepolia testnet.

You can now use the app to:

Issue Credentials: Enter student details (Name, PRN, Degree) and upload a certificate PDF to anchor it on-chain.

Verify Credentials: Drop any certificate file to instantly check its authenticity and metadata for zero gas fees.

Revoke Credentials: Invalidate fraudulent or erroneous certificates from an authorized issuer wallet.
