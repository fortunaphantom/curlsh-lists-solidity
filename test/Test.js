const { expect } = require('chai');
const { BigNumber } = require('ethers');
const { ethers } = require('hardhat');
const Web3 = require('web3');

let owner, addr1, addr2, addr3;
let BinaryTreeTestContract;
let instanceBinaryTreeTest;

let provider = ethers.getDefaultProvider();

const contractName = 'LinkedListTest';

beforeEach(async function () {
  [owner, addr1, addr2, addr3] = await ethers.getSigners();
  BinaryTreeTestContract = await ethers.getContractFactory(contractName);
  instanceBinaryTreeTest = await BinaryTreeTestContract.deploy();
  await instanceBinaryTreeTest.connect(owner).setUp();
});

describe('LinkedListTest', function () {
  it('testRemove', async function () {
    await instanceBinaryTreeTest.connect(owner).testRemove();
  });
});
