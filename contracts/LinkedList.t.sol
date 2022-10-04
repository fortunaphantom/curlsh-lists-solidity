// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./StandardTest.sol";
import "./MyLinkedList.sol";

contract LinkedListTest is StandardTest {
    MyLinkedList List;

    function setUp() public {
        List = new MyLinkedList();
    }

    /*
    * Topic: Lists
    * Problem: Given head of a linked list and key, delete the node that contains the given key
    */
    function testRemove() public {
        List.addTail(1);
        List.addTail(2);
        List.addTail(3);
        List.addTail(4);
        List.addTail(5);
        uint256 key = List.findKeyForData(4);
        List.remove(key);

        // gets 0 if `4` does not exist
        key = List.findKeyForData(4);
        assertTrue(key == 0);
    }
}
