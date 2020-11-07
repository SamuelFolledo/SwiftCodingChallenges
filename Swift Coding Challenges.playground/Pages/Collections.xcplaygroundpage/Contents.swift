//: [Previous](@previous)

import Foundation

/*:
 ## Challenge 37: Count the numbers
 
 Difficulty: Easy
 
 Write an extension for collections of integers that returns the number of times a specific digit appears in any of its numbers.
 ### Sample input and output
 - The code [5, 15, 55, 515].challenge37(count: "5") should return 6.
 - The code [5, 15, 55, 515].challenge37(count: "1") should return 2.
 - The code [55555].challenge37(count: "5") should return 5.
 - The code [55555].challenge37(count: "1") should return 0.
 ### Hints
 - Hint #1: You’ll need to extend the Collection type with a specific constraint rather than a protocol constraint.
 - Hint #2: If you convert each number to a string, you can loop over its characters.
 - Hint #3: If you were functionally inclined, you could solve this challenge using `reduce()` and `filter()`.
 */

extension Collection {
    func challenge37a(count: Character) -> Int {
        var total = 0
        // loop over every element
        for item in self {
            // stringify this integer
            let str = String(item)
            // loop over letter in the string
            for letter in str {
                if letter == count {
                    total += 1
                }
            }
        }
        return total
    }
    func challenge37b(count: Character) -> Int {
        return self.reduce(0) {
            $0 + String($1).filter { (char: Character) -> Bool in
                char == count
            }.count
        }
    }
}

[5, 15, 55, 515].challenge37a(count: "5")


/*:
 ## Challenge 43: Linked lists
 Difficulty: Easy
 Create a linked list of lowercase English alphabet letters, along with a method that traverses all nodes and prints their letters on a single line separated by spaces.
 
 #### Tips
 
 1. This is several problems in one. First, create a linked list data structure, which itself is really two things. Second, use your linked list to create the alphabet. Third, write a method traverses all nodes and prints their letters.
 2. You should use a class for this. Yes, really.
 3. Once you complete your solution, keep a copy of the code – you’ll need it for future challenges!
 
 #### Sample input and output
 • The output of your code should be the English alphabet printed to the screen, i.e. “a b c d … x y z”.
 
 #### Hints
 1. If your first instinct was to create your new data types as a struct, it shows you’re a sound Swift developer. Sadly, I’m afraid that approach won’t work here because structs can’t have stored properties that reference themselves.
 2. Your second instinct might be to use an enum. This makes creation tricksy because you would need to change the associated value after creating the enum.
 3. Even though this challenge uses alphabet letters, aim to make your class generic – it shows smart forward thinking, and is only fractionally harder than using a specific data type.
 4. There are lots of hacky ways to loop over the alphabet. The only sensible way is to use "abcdefghijklmnopqrstuvwxyz" – it’s not hard to write, is self-documenting, and quite safe.
 5. You should create two data types: one for a node, which contains its character and link to the next node in the list, and one for the overall linked list, which contains a property for the first node in the list as well as the print method.
 6. The `print()` function has a terminator parameter.
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
    
    var centerNode: Node<T>? {
        var slow = head
        var fast = head
        while fast != nil && fast?.next != nil { //if fast's next pointer is nil, then the slow is the center node
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    func printNodes() {
        var currentNode = head
        while let node = currentNode {
            print(node.value, terminator: " ")
            currentNode = node.next
        }
    }
    
    //challenge 51a
//    func reversed() -> LinkedList<T> {
//        // create our copy for the return value
//        let copy = LinkedList<T>()
//        // if we have nodes to copy…
//        if let startNode = head {
//            // copy the original start node
//            var previousCopyNode = Node(value: startNode.value)
//            // now start copying from the next node
//            var currentNode = head?.next
//            while let node = currentNode {
//                // create a copy of this node
//                let copyNode = Node(value: node.value)
//                // make it point to the node we created previously
//                copyNode.next = previousCopyNode
//                // then make it the previous node, so we can move forward
//                previousCopyNode = copyNode
//                currentNode = currentNode?.next
//            }
//            // we're at the end of the list, which is our new start
//            copy.head = previousCopyNode
//        }
//        return copy
//    }
    
    //challenge 51b smarter alternative
    func copy() -> LinkedList<T> {
        let copy = LinkedList<T>()
        if let startNode = head {
            copy.head = Node(value: startNode.value) //if we have a head, assign it as copy's head
            var previousCopyNode = copy.head //initialize with copy's head
            var currentNode = head?.next
            while let node = currentNode { //loop through each node after head
                let copyNode = Node(value: node.value) //make a copy node from current node
                previousCopyNode?.next = copyNode //point currentCopy node to new copyNode
                previousCopyNode = copyNode //update currentCopyNode
                currentNode = currentNode?.next //go to next node
            }
        }
        return copy
    }
    
    func reverse() {
        var currentNode = head
        var newNext: Node<T>? = nil
        while let node = currentNode { //loop til the end of list
            let next = node.next //create a copy of the node's next
            node.next = newNext //make the node's next the newNext (nil at first)
            newNext = node //newNext will now be the current node
            currentNode = next //make currentNode the currentNode's original next
        }
        head = newNext
    }
    
    func reversed() -> LinkedList<T> {
        let copy = self.copy()
        copy.reverse() //from the copy created, reverse it
        return copy
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

/*:
 ## Challenge 44: Linked list mid-point
Extend your linked list class with a new method that returns the node at the mid point of the linked list using no more than one loop.

 Tip: If the linked list contains an even number of items, returning the one before or the one after the center is acceptable.

 #### Sample input and output
- If the linked list contains 1, 2, 3, 4, 5, your method should return 3.
- If the linked list contains 1, 2, 3, 4, your method may return 2 or 3.
- If the linked list contains the English alphabet, your method may return M or N.

 #### Hints
1. It’s easy to solve this in two passes, but only fractionally harder to solve it in one.
2. If you use fast enumeration – for i in items – you move over one item at a time. Can you think of a way of moving over more than one item?
3. Once you pull out two items at the same time, you can make them move at different speeds through the list.
4. If you move pointer A through the list one item at a time, and pointer B through the list two items at a time, by the time pointer B reaches the end where will pointer A be?
*/
//Solution... check centerNode in LinkedList
print("\nCenter Node = \(list.centerNode!.value)")

/*:
 ## Challenge 51: Reversing linked lists
 
 Expand your code from challenge 43 so that it has a reversed() method that returns a copy of itself in reverse.
 
 Tip: Don’t cheat! It is not a solution to this problem just to reverse the alphabet letters before you create your linked list. Create the linked list alphabetically, then write code to reverse it.
 
 #### Sample input and output
 
 - When you call reversed() on your alphabet list, running printNodes() on the
 return value should print the English alphabet printed to the screen in reverse, i.e. “z y x … d b c a”.
 
 #### Hints
 1. Most of the work is just producing a copy of the linked list.
 2. Having to work on a copy makes this a little more interesting.
 3. You could create two methods: one for copying, and one for reversing a copy in place. If you do this, please think carefully about Swift’s naming conventions! Hint #4: You need to create a newNext variable that starts as nil. Then traverse the full list, pull out its next value, then change the current node’s next property to be newNext. You can then continue on to whatever node was in next, and repeat until the end of the list is reached.

 */
print("\n")
list.reversed().printNodes()
