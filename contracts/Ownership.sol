// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ownership{

address public manager;

struct Document{
 address onwer;   
 string documentId;
 string documentHash;
 string signatureHash;
 uint verificationCount;
 mapping (address => bool) verifications;
}

// struct Returndoc{
//  address onwer;   
//  string documentId;
//  string documentHash;
//  string signatureHash;
//  uint verificationCount;
//  string[] verifiers;
// }

uint numDocuments = 0;

mapping (string => uint) documentIndex;

mapping (uint => Document) public uploads;

mapping (address => bool) verifiers;

mapping (string => bool) documentCheck;

//Document[] public uploads;

constructor() {
    manager = msg.sender;
}

modifier restricted(){
    require(msg.sender == manager);
    _;
}

modifier isVerifier(){
    require(verifiers[msg.sender]);
    _;
}

    
function registerVerifier( address verifier) public restricted{
verifiers[verifier] = true;
}

// function getVerifiers() public view returns (address[] memory){
//     return verifiers;
// }

function upload(string memory documentId, string memory documentHash, string memory signatureHash) public{

    documentCheck[documentId] = true;
    documentIndex[documentId] = numDocuments;

    Document storage newDocument = uploads[numDocuments++];
        newDocument.onwer = msg.sender;
        newDocument.documentId = documentId;
        newDocument.documentHash = documentHash;
        newDocument.signatureHash = signatureHash;
        newDocument.verificationCount = 0;

    // Document memory newDocument = Document({
    //     onwer:msg.sender,
    //     documentId:documentId,
    //     documentHash:documentHash,
    //     signatureHash:signatureHash,
    //     verificationCount:0
    //});
    //uploads.push(newDocument);
}

function verifyDocument(string memory documentId) public isVerifier{
    require(documentCheck[documentId]);
    uint index;
    index = documentIndex[documentId];
    Document storage document = uploads[index];
    
    require(!document.verifications[msg.sender]);
    document.verifications[msg.sender] = true;
    document.verificationCount++;
}

// function getVerifications(string memory documentId) public view returns(Returndoc){
//     require(documentCheck[documentId]);
//     uint index;
//     index = documentIndex[documentId];
//     Document storage document = uploads[index];
//     Returndoc memory newDocument = Returndoc({
//         onwer:document.onwer,
//         documentId:document.documentId,
//         documentHash:document.documentHash,
//         signatureHash:document.signatureHash,
//         verificationCount:document.verificationCount,
//         verifiers:document.verifications[msg.sender]
//     });
//     return newDocument;
// }

}
