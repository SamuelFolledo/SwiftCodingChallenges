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
            guard let item = item as? Int else { return total }
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
    
    //clearer but will more than likely perform slower
    //reduce() to whittle down the array of integers into a single number, then use filter() on each item to pick out characters that match the input digit
    func challenge37b(count: Character) -> Int {
        return self.reduce(0) {
            guard let currentNumber = $1 as? Int else { return 0 }
            return $0 + String(currentNumber).filter { (char: Character) -> Bool in
                char == count
            }.count
        }
    }
}

[5, 15, 55, 515].challenge37b(count: "5")


/*:
 ## Challenge 38: Find N smallest
 Difficulty: Easy
 
 Write an extension for all collections that returns the  N smallest elements as an array, sorted smallest first, where N is an integer parameter.
 ### Sample input and output
 - The code `[1, 2, 3, 4].challenge38(count: 3)` should return [1, 2, 3].
 - The code `["q", "f", "k"].challenge38(count: 10)` should return [“f”, “k”, “q”].
 - The code `[256, 16].challenge38(count: 3)` should return [16, 256].
 - The code `[String]().challenge38(count: 3)` should return an empty
 array.
 ### Hints
 - Hint #1: You’ll need to extend the `Collection` type with a constraint.
 - Hint #2: Finding the smallest of any value requires using the `<` operator, which is guaranteed to exist when something conforms to `Comparable`.
 - Hint #3: The collection might be contain fewer than *N* items.
 - Hint #4: The solution is made more interesting by the requirement to return a variable number of results. Hint #5: If you want to avoid complexity, use `sorted()`.

 */

extension Collection where Iterator.Element: Comparable {
    func challenge38(count: Int) -> [Iterator.Element] {
        let sorted = self.sorted() //sort, ascending by default
        return Array(sorted.prefix(count)) //get the first count amount of elements from the sorted array
    }
}

/*:
 ## Challenge 39: Sort a string array by length
 Difficulty: Easy
 
 Extend collections with a function that returns an array of strings sorted by their lengths, longest first.
 ### Sample input and output
 - The code `["a", "abc", "ab"].challenge39()` should return `["abc","ab", "a"]`.
 - The code `["paul", "taylor", "adele"].challenge39()` should return `["taylor", "adele", "paul"]`.
 - The code `[String]().challenge39()` should return `[]`.
 ### Hints
 - Hint #1: You’ll need to extend the Collection type with a specific constraint rather than a protocol constraint.
 - Hint #2: You should use the built-in `sorted()` method.
 - Hint #3: You can provide a custom closure to `sorted()` to affect how it works.
 */
extension Collection where Iterator.Element == String {
    func challenge39() -> [String] {
        return self.sorted { $0.count > $1.count }
    }
}

["paul", "taylor", "adele"].challenge39()

/*:
 ## Challenge 40: Missing numbers in array
 Difficulty: Easy
 
 Create a function that accepts an array of unsorted numbers from 1 to 100 where zero or more numbers might be missing, and returns an array of the missing numbers.
 ### Sample input and output
 If your test array were created like this:
 `var testArray = Array(1...100)`
 `testArray.remove(at: 25)`
 `testArray.remove(at: 20)`
 `testArray.remove(at: 6)`
 Then your method should `[7, 21, 26]`, because those are the numbers missing from the array.
 ### Hints
 - Hint #1: There’s a naïve solution involving arrays, but it’s very slow.
 - Hint #2: You should try using a `Set`, which has a significantly faster `contains()` method.
 - Hint #3: You can compute the different between two sets using `symmetricDifference()`.
 */
//slow solution because array.contains() is O(n)
func challenge40a(input: [Int]) -> [Int] {
    let correctArray = Array(1...100)
    var missingNumbers = [Int]()
    for number in correctArray {
        if !input.contains(number) {
            missingNumbers.append(number)
        }
    }
    return missingNumbers
}

//faster becase set.contains() is O(1)
func challenge40b(input: [Int]) -> [Int] {
    let correctArray = Array(1...100)
    let inputSet = Set(input)
    var missingNumbers = [Int]()
    for number in correctArray {
        if !inputSet.contains(number) {
            missingNumbers.append(number)
        }
    }
    return missingNumbers
}

//50% slower than solution above because it is turning the set into an array and sorting it
func challenge40c(input: [Int]) -> [Int] {
    let inputSet = Set(input)
    let testSet = Set(1...100)
    return Array(testSet.subtracting(inputSet)).sorted()
}

/*:
 ## Challenge 41: Find the median
 Difficulty: Easy
 
 Write an extension to collections that accepts an array of Int and returns the median average, or nil if there are no values.
 
 **Tip**: The mean average is the sum of some numbers divided by how many there are. The *median* average is the middle of a sorted list. If there is no single middle value – e.g. if there are eight numbers - then the median is the mean of the two middle values.
 ### Sample input and output
 - The code `[1, 2, 3].challenge41()` should return 2.
 - The code `[1, 2, 9].challenge41()` should return 2.
 - The code `[1, 3, 5, 7, 9].challenge41()` should return 5.
 - The code `[1, 2, 3, 4].challenge41()` should return 2.5.
 - The code `[Int]().challenge41()` should return nil.
 
 ### Hints
 - Hint #1: You’ll need to extend `Collection` with a specific constraint.
 - Hint #2: The method should return `Double`? because it might be a whole number, it might be a mean average of two numbers, or it might be nil if the collection is empty.
 - Hint #3: If you divide an odd integer by two, Swift will round down.
 - Hint #4: If you divide an even-numbered collection’s count by two, you’ll get the highest of the two values you need for your mean.
 - Hint #5: Make life easy for yourself: sort the collection first.
 */

extension Collection where Iterator.Element == Int {
    func challenge41() -> Double? {
        guard count != 0 else { return nil }
        // sort the items so we can find the center point
        let sorted = self.sorted()
        let middle = sorted.count / 2
        if sorted.count % 2 == 0 {
            // return mean average of two center items
            return Double(sorted[middle] + sorted[middle - 1]) / 2
        } else {
            // return the single center item
            return Double(sorted[middle])
        }
    }
}

        
/*:
 ## Challenge 42: Recreate index(of:)
 Difficulty: Easy
 
 Write an extension for all collections that reimplements the `index(of:)` method. Tip: This is one of the easiest standard library methods to reimplement, so please give it an especially good try before reading any hints.
 ### Sample input and output
 - The code `[1, 2, 3].challenge42(indexOf: 1)` should return 0.
 - The code `[1, 2, 3].challenge42(indexOf: 3)` should return 2.
 - The code `[1, 2, 3].challenge42(indexOf: 5)` should return nil.
 ### Hints
 - Hint #1: You will need to extend `Collection` using a constraint on the type of element it stores.
 - Hint #2: Your return type should be `Int?` because the item might not exist in the collection. Hint #3: This would be a good time to use `enumerated()` to retrieve items and their index from a collection.
 */

extension Collection where Iterator.Element: Equatable {
    func challenge42(indexOf search: Iterator.Element) -> Int? {
        for (index, item) in self.enumerated() {
            if item == search {
                return index
            }
        }
    return nil
    }
}


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

//var list = LinkedList<Character>()
//var previousNode: Node<Character>? = nil
//
//for letter in "abcdefghijklmnopqrstuvwxyz" {
//    let node = Node(value: letter)
//    if let predecessor = previousNode { //if there's a node, then point it to this newly created node
//        predecessor.next = node
//    } else { //assign it as list's head
//        list.head = node
//    }
//    previousNode = node
//}
//list.printNodes()

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
//print("\nCenter Node = \(list.centerNode!.value)")

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
//print("\n")
//list.reversed().printNodes()

/*:
 ## Challenge 45: Traversing the tree
 Difficulty: Easy
 
 **Note**: this challenge cannot be attempted until you have first completed challenge 54.
 
 Write a new method for your binary search tree that traverses the tree in order, running a closure on each node.
 
 **Tip**: Traversing a node in order means visiting its left value, then visiting its own value, then visiting its right value.
 ### Sample input and output
 Assuming a binary tree created from the array [2, 1, 3]:
 - The code `tree.root?.traverse { print($0.key) }` should print 1, 2, 3.
 - The code `var sum = 0; tree.root?.traverse { sum += $0.key }; print(sum)` should print 6.
 - The code `var values = [Int](); tree.root?.traverse { values.append($0.key) }; print(values.count)` should print 3.
 ### Hints
 - Hint #1: Your entire function can be just three lines of code. Yes, it really is that easy – hurray for recursion!
 - Hint #2: You can write this method for the binary tree class or for its nodes; it really doesn’t matter. I chose to write it for the nodes so that I can print partial trees.
 - Hint #3: Make sure it accepts a closure parameter that itself accepts one parameter (your Node<T> equivalent) and returns void. Hint #4: Remember the left and/or right node may not exist.

 */

/*:
 ## Challenge 54: Binary search trees
 Difficulty: Taxing
 
 Create a binary search tree data structure that can be initialized from an unordered array of comparable values, then write a method that returns whether the tree is balanced.
 
 **Tip #1**: There is more than one description of a balanced binary tree. For the purpose of this challenge, a binary tree is considered balanced when the height of both subtrees for every node differs by no more than 1.
 
 **Tip #2**: Once you complete this challenge, keep your code around because you’ll need it in the next one.
 
 ### Sample input and output
 The following values should create balanced trees:
 - [2, 1, 3]
 - [5, 1, 7, 6, 2, 1, 9]
 - [5, 1, 7, 6, 2, 1, 9, 1]
 - [5, 1, 7, 6, 2, 1, 9, 1, 3]
 - [50, 25, 100, 26, 101, 24, 99]
 - ["k", "t", "d", "a", "z", "m", "f"]
 - [1]
 - [Character]()
 
 The following values should not create balanced trees:
 - [1, 2, 3, 4, 5]
 - [10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15]
 - ["f", "d", "c", "e", "a", "b"]
 ### Hints
 - Hint #1: You need to create a binary search tree rather than a plain binary tree. This means inserting nodes into the tree based on whether they are less than or equal (left) or greater than (right) their parent.
 - Hint #2: You should make your data types use a generic value that conforms to `Comparable`.
 - Hint #3: Each nodes should have a value, plus left and right optional nodes.
 - Hint #4: To find the correct place for each array item, start at the top of your tree then keep moving left or right until you find nil – that’s your place.
 - Hint #5: You might find it useful to make your binary tree type conform to `CustomStringConvertible` so you can add a custom `var description: String` that prints the contents of your tree.
 - Hint #6: Checking a binary tree is balanced can be done by recursively comparing the minimum depth of both sides of a node against the maximum depth of both sides of a node. The tree can be considered balanced if the two values differ by no more than 1.

 */

/*: ### Pseudocode:
 1. Loop over every item in the array.
 2. If we have a root node already, set it to be our tracker node – that’s the one we’re currently comparing against.
 3. If the item is less than or equal to our tracker, and the tracker’s left value is nil, make a
 new node from our item, make it the tracker’s left value, then mark this item as being placed.
 4. If the item is less than or equal to our tracker but we already have a left value, make that left value our new tracker and repeat the loop.
 5. If the item is greater than our tracker, and tracker’s right value is nil, make a new node from our item, make it the tracker’s right value, then mark this item as being placed.
 6. If the item is greater than our tracker but we already have a right value, make that right value our new tracker and repeat the loop.
 7. If we don’t already have a root node, make one from the item and make that the tracker.
 */

class TreeNode<T> {
    var key: T
    var left: TreeNode<T>?
    var right: TreeNode<T>?
    init(key: T) {
        self.key = key
    }
}

class BinarySearchTree<T: Comparable> {
    ///The nodes it contains must store data that conforms to `Comparable` in order to place an item to the left of a node if it is less than or equal to it, or to the right of a node otherwise – we need to compare values
    var root: TreeNode<T>?
    
    init(array: [T]) {
        for item in array {
            if let rootNode = root {
                var placed = false // this will be set to true when we've created a node from this item
                var tracker = rootNode // we have a root node, so make it our tracker
                while placed == false {
                    // if we're placing an item that comes before our tracker
                    if item <= tracker.key {
                        // if we don't already have a left node
                        if tracker.left == nil {
                            // make this item our left node
                            tracker.left = TreeNode(key: item)
                            // mark it as placed
                            placed = true
                        }
                        tracker = tracker.left! // we already have a left node; make that the tracker so we can compare against it.
                    } else { // this item is greater than our tracker, so it needs to sit on its right
                        if tracker.right == nil { // if we don't already have a right node
                            // make this item our right node
                            tracker.right = TreeNode(key: item)
                            placed = true // mark it as placed
                        }
                        tracker = tracker.right! // we already have a right node; make that the tracker so we can compare against it.
                    }
                }
            } else {
                root = TreeNode(key: item)
            }
        }
    }
}

