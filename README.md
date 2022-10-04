# curlsh-binarytree-solidity

## How to install
- yarn install
This is the hardhat project, so necessary node_modules should be installed.

- yarn compile
You can check this command in the package.json. This runs the hardhat compile command.

- yarn test
This runs the hardhat test command

## About
- StandardTest.sol: Standard test script functions are defined
- StandardBinaryTree.sol: STandard binary tree implementation
- MyBinaryTree.sol: There are two public functions and two internal helper functions for the problem 1 and problem 2
- BinaryTree.t.sol: Binary Tree testing script

## Problem 1
Description: Create a function that swaps left & right children for each node within a binary tree, given the root node
Solution: swapChildren() function

## Problem 2
Description: Create a function that returns bool, checks if two binary trees are identical, given the root of each
Solution: compareNodes() function