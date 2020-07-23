//: [Previous](@previous)

import Foundation

//extension Collection {
//    func challenge37a(count: Character) -> Int {
//        var total = 0
//        // loop over every element
//        for item in self {
//            // stringify this integer
//            let str = String(item)
//            // loop over letter in the string
//            for letter in str {
//                if letter == count {
//                    total += 1
//                }
//            }
//        }
//        return total
//    }
////    func challenge37b(count: Character) -> Int {
////        return self.reduce(0) {
////            $0 + String($1).filter { (char: Character) -> Bool in
////                char == count
////            }.count
////        }
////    }
//}
//
//[5, 15, 55, 515].challenge37a(count: "5")


/*
 Challenge 43: Linked lists
 Difficulty: Easy
 Create a linked list of lowercase English alphabet letters, along with a method that traverses all nodes and prints their letters on a single line separated by spaces.
 Tip #1: This is several problems in one. First, create a linked list data structure, which itself is really two things. Second, use your linked list to create the alphabet. Third, write a method traverses all nodes and prints their letters.
 Tip #2: You should use a class for this. Yes, really.
 Tip #3: Once you complete your solution, keep a copy of the code – you’ll need it for future challenges!
 Sample input and output
 • The output of your code should be the English alphabet printed to the screen, i.e. “a b c
 d … x y z”.
 Hints Hint #1: If your first instinct was to create your new data types as a struct, it shows you’re a sound Swift developer. Sadly, I’m afraid that approach won’t work here because structs can’t have stored properties that reference themselves.
 Hint #2: Your second instinct might be to use an enum. This makes creation tricksy because you would need to change the associated value after creating the enum.
 Hint #3: Even though this challenge uses alphabet letters, aim to make your class generic – it shows smart forward thinking, and is only fractionally harder than using a specific data type.
 Hint #4: There are lots of hacky ways to loop over the alphabet. The only sensible way is to use "abcdefghijklmnopqrstuvwxyz" – it’s not hard to write, is self-documenting, and quite safe.
 www.hackingwithswift.com
 quite safe.
 Hint #5: You should create two data types: one for a node, which contains its character and link to the next node in the list, and one for the overall linked list, which contains a property for the first node in the list as well as the print method.
 Hint #6: The print() function has a terminator parameter.
 */

class Node<T> {
    var value: T
    var next: Node?
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var head: Node<T>?
    
    func printNodes() {
        var currentNode = head
        while let node = currentNode {
            print(node.value, terminator: " ")
            currentNode = node.next
        }
    }
}

var list = LinkedList<Character>()
var previousNode: Node<Character>? = nil

for letter in "abcdefghijklmnopqrstuvwxyz" {
    let node = Node(value: letter)
    if let predecessor = previousNode { //if there's a node, then point it to this newly created node
        predecessor.next = node
    } else { //assign it as list's head
        list.head = node
    }
    previousNode = node
}
list.printNodes()
