//: [Previous](@previous)

import Foundation


//: # Karat Interview Prep part 2
/*
 // Suppose we have some input data describing a graph of relationships between parents and children over multiple generations. The data is formatted as a list of (parent, child) pairs, where each individual is assigned a unique integer identifier.

 // For example, in this diagram, 3 is a child of 1 and 2, and 5 is a child of 4:

 // 1   2    4   15
 //  \ /   / | \ /
 //   3   5  8  9
 //    \ / \     \
 //     6   7    11

 // Sample input/output (pseudodata):

 // parentChildPairs = [
 //     (1, 3), (2, 3), (3, 6), (5, 6), (15, 9),
 //     (5, 7), (4, 5), (4, 8), (4, 9), (9, 11)
 // ]

 // Write a function that takes this data as input and returns two collections: one containing all individuals with zero known parents, and one containing all individuals with exactly one known parent.

 // Output may be in any order:

 // findNodesWithZeroAndOneParents(parentChildPairs) => [
 //   [1, 2, 4, 15],       // Individuals with zero parents
 //   [5, 7, 8, 11]        // Individuals with exactly one parent
 // ]

 */

import Foundation;

let parentChildPairs = [
  [1, 3], [2, 3], [3, 6], [5, 6], [15, 9],
  [5, 7], [4, 5], [4, 8], [4, 9], [9, 11]
]

func findNodesWithZeroAndOneParents(parentChildPairs: [[Int]]) {
  var dic = [Int: [Int]]() //dictionary of child as keys and parents as values

  for pair in parentChildPairs {
    let child = pair[1]
    let parent = pair[0]
    if !dic.keys.contains(child) { //if child doesn't exist in our dic...
      dic[child] = []
    }
    if !dic.keys.contains(parent) { //if parent doesn't exist in our dic...
      dic[parent] = []
    }
    dic[child]!.append(parent) //add parent to child's array of parents
  }
  
  var zeroParents = [Int]()
  var oneParents = [Int]()
  for item in dic {
    if item.value.count == 0 { //if item's parents array count is 0...
      zeroParents.append(item.key)
    }
    if item.value.count == 1 {
      oneParents.append(item.key)
    }
  }
  print(zeroParents, oneParents)
}

findNodesWithZeroAndOneParents(parentChildPairs: parentChildPairs)

//THANK YOU SO MUCH 👍

// Hi Samue; Here's the next question if you want to keep practicing:
// Bevan/ :)


// Please do not share the questions asked with your peers or online – we want other engineers to have the same practice experience you had.


// Suppose we have some input data describing a graph of relationships between parents and children over multiple generations. The data is formatted as a list of (parent, child) pairs, where each individual is assigned a unique integer identifier.

// For example, in this diagram, 6 and 8 have common ancestors of 4 and 14.

//          14  13
//          |   |
// 1   2    4   12
//  \ /   / | \ /
//   3   5  8  9
//    \ / \     \
//     6   7     11

// parentChildPairs1 = [
//     (1, 3), (2, 3), (3, 6), (5, 6), (5, 7), (4, 5),
//     (4, 8), (4, 9), (9, 11), (14, 4), (13, 12), (12, 9)
// ]

// Write a function that takes the graph, as well as two of the individuals in our dataset, as its inputs and returns true if and only if they share at least one ancestor.

// Sample input and output:

// hasCommonAncestor(parentChildPairs1, 3, 8) => false
// hasCommonAncestor(parentChildPairs1, 5, 8) => true
// hasCommonAncestor(parentChildPairs1, 6, 8) => true
// hasCommonAncestor(parentChildPairs1, 6, 9) => true
// hasCommonAncestor(parentChildPairs1, 1, 3) => false
// hasCommonAncestor(parentChildPairs1, 3, 1) => false
// hasCommonAncestor(parentChildPairs1, 7, 11) => true
// hasCommonAncestor(parentChildPairs1, 6, 5) => true
// hasCommonAncestor(parentChildPairs1, 5, 6) => true

// Additional example: In this diagram, 4 and 12 have a common ancestor of 11.

//         11
//        /  \
//       10   12
//      /  \
// 1   2    5
//  \ /    / \
//   3    6   7
//    \        \
//     4        8

// parentChildPairs2 = [
//     (1, 3), (11, 10), (11, 12), (2, 3), (10, 2),
//     (10, 5), (3, 4), (5, 6), (5, 7), (7, 8),
// ]

// hasCommonAncestor(parentChildPairs2, 4, 12) => true
// hasCommonAncestor(parentChildPairs2, 1, 6) => false
// hasCommonAncestor(parentChildPairs2, 1, 12) => false

// n: number of pairs in the input


let parentChildPairs1 = [
    [1, 3], [2, 3], [3, 6], [5, 6], [5, 7], [4, 5],
    [4, 8], [4, 9], [9, 11], [14, 4], [13, 12], [12, 9]
]

let parentChildPairs2 = [
    [1, 3], [11, 10], [11, 12], [2, 3], [10, 2],
    [10, 5], [3, 4], [5, 6], [5, 7], [7, 8]
]

//: [Next](@next)
