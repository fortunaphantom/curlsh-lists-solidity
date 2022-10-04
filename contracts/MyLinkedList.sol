// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract MyLinkedList {
    event NodeCreated(uint256 key, uint256 data);
    event NodesLinked(uint256 prev, uint256 next);
    event NodeRemoved(uint256 key);
    event NewHead(uint256 key);

    struct Node {
        uint256 key;
        uint256 next;
        uint256 data;
    }

    uint256 public head;
    uint256 public keyCounter;
    mapping (uint256 => Node) public nodes;

    constructor() {
        head = 0;
        keyCounter = 1;
    }

    // Retrieves the Node denoted by `_key`.
    function get(uint256 _key)
        public
        virtual
        view
        returns (uint256, uint256, uint256)
    {
        Node memory node = nodes[_key];
        return (node.key, node.next, node.data);
    }

    // Given a node, denoted by `_key`, returns the key of the Node that points to it, or 0 if `_key` refers to the Head.
    function findPrevKey(uint256 _key)
        public
        virtual
        view
        returns (uint256)
    {
        if (_key == head) return 0;
        Node memory prevNode = nodes[head];
        while (prevNode.next != _key) {
            prevNode = nodes[prevNode.next];
        }
        return prevNode.key;
    }

    // Returns the key for the Tail.
    function findTailKey()
        public
        virtual
        view
        returns (uint256)
    {
        Node memory oldTailNode = nodes[head];
        while (oldTailNode.next != 0) {
            oldTailNode = nodes[oldTailNode.next];
        }
        return oldTailNode.key;
    }

    // Insert a new Node as the new Head with `_data` in the data field.
    function addHead(uint256 _data)
        public
        virtual
    {
        uint256 objectKey = _createNode(_data);
        _link(objectKey, head);
        _setHead(objectKey);
    }

    // Insert a new Node as the new Tail with `_data` in the data field.
    function addTail(uint256 _data)
        public
        virtual
    {
        if (head == 0) {
            addHead(_data);
        }
        else {
            uint256 oldTailKey = findTailKey();
            uint256 newTailKey = _createNode(_data);
            _link(oldTailKey, newTailKey);
        }
    }

    // Insert a new Node after the Node denoted by `_key` with `_data` in the data field.
    function insertAfter(uint256 _prevKey, uint256 _data)
        public
        virtual
    {
        Node memory prevNode = nodes[_prevKey];
        uint256 newNodeKey = _createNode(_data);
        _link(newNodeKey, prevNode.next);
        _link(prevNode.key, newNodeKey);
    }

    // Insert a new Node before the Node denoted by `_key` with `_data` in the data field.
    function insertBefore(uint256 _nextKey, uint256 _data)
        public
        virtual
    {
        if (_nextKey == head) {
            addHead(_data);
        }
        else {
            uint256 prevKey = findPrevKey(_nextKey);
            insertAfter(prevKey, _data);
        }
    }

    // Internal function to update the Head pointer.
    function _setHead(uint256 _key)
        internal
    {
        head = _key;
        emit NewHead(_key);
    }

    // Internal function to create an unlinked Node.
    function _createNode(uint256 _data)
        internal
        returns (uint256)
    {
        uint256 newKey = keyCounter;
        keyCounter += 1;
        Node memory object = Node(newKey, 0, _data);
        nodes[object.key] = object;
        emit NodeCreated(
            object.key,
            object.data
        );
        return object.key;
    }

    // Internal function to link a node to another.
    function _link(uint256 _prevKey, uint256 _nextKey)
        internal
    {
        nodes[_prevKey].next = _nextKey;
        emit NodesLinked(_prevKey, _nextKey);
    }

    // Return the key of the first Object matching `_data` in the data field.
    // return 0 if _data does not exist in the array
    function findKeyForData(uint256 _data)
        public
        virtual
        view
        returns (uint256)
    {
        Node memory node = nodes[head];
        while (node.data != _data && node.key != 0) {
            node = nodes[node.next];
        }

        return node.key;
    }

    
    /*
    * Topic: Lists
    * Problem: Given head of a linked list and key, delete the node that contains the given key
    */

    // Remove the Node denoted by `_key` from the List.
    function remove(uint256 _key)
        public
        virtual
    {
        Node memory removeNode = nodes[_key];
        if (head == _key) {
            _setHead(removeNode.next);
        }
        else {
            uint256 prevNodeKey = findPrevKey(_key);
            _link(prevNodeKey, removeNode.next);
        }
        delete nodes[removeNode.key];
        emit NodeRemoved(_key);
    }

}
