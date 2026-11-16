// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CredentialRegistry {
    address public admin;

    struct Credential {
        string studentName;
        string prn;
        string degreeTitle;
        uint256 issuedAt;
        address issuedBy;
        bool isRevoked;
    }

    mapping(bytes32 => Credential) private credentials;
    mapping(address => bool) public authorizedIssuers;

    event CredentialIssued(bytes32 indexed docHash, string prn, address indexed issuer);
    event CredentialRevoked(bytes32 indexed docHash, address indexed revokedBy);
    event IssuerUpdated(address indexed issuer, bool status);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyIssuer() {
        require(authorizedIssuers[msg.sender], "Caller is not an authorized issuer");
        _;
    }

    constructor() {
        admin = msg.sender;
        authorizedIssuers[msg.sender] = true;
    }

    function setIssuerStatus(address _issuer, bool _status) external onlyAdmin {
        authorizedIssuers[_issuer] = _status;
        emit IssuerUpdated(_issuer, _status);
    }

    function issueCredential(
        bytes32 _docHash,
        string memory _studentName,
        string memory _prn,
        string memory _degreeTitle
    ) external onlyIssuer {
        require(_docHash != bytes32(0), "Invalid document hash");
        require(credentials[_docHash].issuedAt == 0, "Document already registered");

        credentials[_docHash] = Credential({
            studentName: _studentName,
            prn: _prn,
            degreeTitle: _degreeTitle,
            issuedAt: block.timestamp,
            issuedBy: msg.sender,
            isRevoked: false
        });

        emit CredentialIssued(_docHash, _prn, msg.sender);
    }

    function revokeCredential(bytes32 _docHash) external onlyIssuer {
        require(credentials[_docHash].issuedAt != 0, "Document does not exist");
        require(!credentials[_docHash].isRevoked, "Credential is already revoked");

        credentials[_docHash].isRevoked = true;
        emit CredentialRevoked(_docHash, msg.sender);
    }

    function verifyCredential(bytes32 _docHash)
        external
        view
        returns (
            bool exists,
            string memory studentName,
            string memory prn,
            string memory degreeTitle,
            uint256 issuedAt,
            address issuedBy,
            bool isRevoked
        )
    {
        Credential memory cred = credentials[_docHash];
        if (cred.issuedAt == 0) {
            return (false, "", "", "", 0, address(0), false);
        }
        return (
            true,
            cred.studentName,
            cred.prn,
            cred.degreeTitle,
            cred.issuedAt,
            cred.issuedBy,
            cred.isRevoked
        );
    }
}