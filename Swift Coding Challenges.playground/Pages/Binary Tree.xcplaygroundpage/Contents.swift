//: [Previous](@previous)

import UIKit

//MARK: Recursive Search through Binary Tree (https://www.youtube.com/watch?v=beQEimO3-3E)
/*
                10
               /  \
              5    14
             /    /  \
            1    11   20
*/

class Node {
    let value: Int
    var leftChild: Node?
    var rightChild: Node?
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

//left branch
let node1 = Node(value: 1, leftChild: nil, rightChild: nil)
let node5 = Node(value: 5, leftChild: node1, rightChild: nil)

//right branch
let node11 = Node(value: 11, leftChild: nil, rightChild: nil)
let node20 = Node(value: 20, leftChild: nil, rightChild: nil)
let node14 = Node(value: 14, leftChild: node11, rightChild: node20)

//root Node
let rootNode = Node(value: 10, leftChild: node5, rightChild: node14)

func search(node: Node?, searchValue: Int) -> Bool {
    if node == nil { //if node is nil and return false
        return false
    }
    
    if node?.value == searchValue {
        return true
    } else {
        return search(node: node?.leftChild, searchValue: searchValue) || search(node: node?.rightChild, searchValue: searchValue)
    }
}

search(node: rootNode, searchValue: 11)
//: [Next](@next) shashank - communications platforms team - uber driver
