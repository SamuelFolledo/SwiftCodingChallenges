//: [Previous](@previous)

import Foundation

class Node {
    var value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
}

class LinkedList {
    var head: Node?
    
    func insert(value: Int) { //insert to the end
        if head == nil { //check for empty list
            head = Node(value: value, next: nil)
            return
        }
        var current = head
        while current?.next != nil { //while we are not at the tail... check next
            current = current?.next
        }
        current?.next = Node(value: value, next: nil) //once we are at the tail, we will create a new node that the tail will be pointing to
    }
    
    func delete(value: Int) {
        if head?.value == value { //if head has the value... head's next will now be the head
            head = head?.next
            return
        }
        var prev: Node?
        var current = head
        while current?.next != nil && current?.value != value { //while current is not tail and current value is not the value we are looking for... assign current to prev and current will be the next
            prev = current
            current = current?.next
        }
        prev?.next = current?.next
    }
    
    func insertInOrder(value: Int) {
        if head == nil || head?.value ?? Int.min >= value { //check if head is empty OR head's value is greater than value parameter... if it is then create a new head node with value parameter and next node will be nil or head
            head = Node(value: value, next: head)
            return
        }
        var current: Node? = head
        while current?.next != nil && current?.next?.value ?? Int.min < value { //while not tail AND current's next.value is less than value parameter, then keep traversing. //meaning loop will only stop when current's next.value is greater than value passed
            current = current?.next
        }
        current?.next = Node(value: value, next: current?.next)
    }
    
    func displayListItems() {
        print("Here is what's inside your list")
        var current = head
        while current != nil { //will iterate until reaching tail when next is nil
            print(current!.value)
            current = current?.next
        }
    }
}

//let list = LinkedList()
//list.insert(value: 1)
//list.insert(value: 2)
////list.insert(value: 3)
//list.insert(value: 4)
//list.insert(value: 5)
////list.delete(value: 5)
//list.insertInOrder(value: 3)
//list.displayListItems()

let node4 = Node(value: 4, next: nil)
let node3 = Node(value: 3, next: node4)
let node2 = Node(value: 2, next: node3)
let node1 = Node(value: 1, next: node2)

func printList(head: Node?) {
    var current = head
    while current != nil {
        print(current?.value ?? -1)
        current = current?.next
    }
}

print(printList(head: node1))

func reverseList(head: Node?) -> Node? { //trick here is each traverse, we want to change the current's next to point to previous (nil at start) before assigning previous as current.
    print("Reversed List")
    var current = head
    var prev: Node?
    var next: Node?
    while current != nil { //loop til we get to tail
        next = current?.next //before we change current.next to be previous, assign next as the current.next
        current?.next = prev //current next will be the previous node
//        print("Prev = \(prev?.value ?? -1), Current = \(current?.value ?? -1), Next = \(next?.value ?? -1)")
        prev = current //
        current = next //we had to create a next reference to assign as new current because we will change the current's next to the previous node
    }
    return prev
}

print(printList(head: reverseList(head: node1)))


/*
REFERENCES:
 https://www.youtube.com/watch?v=gNu-F_LnC0I
 */
//: [Next](@next)







//Advanced LinkedList sample

//func that removes all the occurences of a ll
// if ll was 1,6,8,8,4 [4] -> 1,6,8,8
public class TNode<T> {
    public var value: T
    public var next: TNode?
    
    public init(value: T, next: TNode? = nil) {
        self.value = value
        self.next = next
    }
}

extension TNode: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

public struct TLinkedList<T> {
    
    public var head: TNode<T>?
    public var tail: TNode<T>?
    public var size: Int = 0
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }

    ///Adding at the beginning of the list (head-first insertion).
    public mutating func push(_ value: T) {
        head = TNode(value: value, next: head)
        if tail == nil {
            tail = head
        }
        size += 1
    }
    
    ///Adds a value at the end of the list (tail-end insertion).
    public mutating func append(_ value: T) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = TNode(value: value)
        tail = tail!.next
        size += 1
        
    }
    
    ///Inserts a value in a specific place in the list.
    ///- First find the node
    ///- Then insert the new node
//    public func insertTNode(at index: Int) -> TNode<T>? {
//        var currentNode = head
//        var currentIndex = 0
//
//        while currentNode != nil && currentIndex < index {
//            currentNode = currentNode!.next
//            currentIndex += 1
//        }
//        return currentNode
//    }
    
    ///insert a value
    @discardableResult public mutating func insert(_ value: T, after node: TNode<T>) -> TNode<T> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = TNode(value: value, next: node.next)
        size += 1
        return node.next!
    }
    
    ///Removes the first node.
    @discardableResult public mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        size -= 1
        return head?.value
    }
    
    ///Removes the last node
    @discardableResult public mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        size -= 1
        return current.value
    }
    
    ///Removes a value at a specific index
    @discardableResult public mutating func remove(after node: TNode<T>) -> T? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        size -= 1
        return node.next?.value
    }
    
    func displayListItems() {
        print("Here is what's inside your list")
        var current = head
        while current != nil { //will iterate until reaching tail when next is nil
            print(current!.value,"\n---------")
            current = current?.next
        }
    }
}

extension TLinkedList where T: Equatable {
    
    public mutating func removeOccurences(num: T) {
        if size == 0 {
            return
        }
        //create a prev
        var prev = head
        var current = head?.next
        if prev?.value == num { //if head has the value
            pop()
        }
        //go through each node's data starting at head and see if the node's data is a num
        while current != nil {
            if current?.value == num {
                prev?.next = current?.next
            }
            prev = current
            current = current?.next
        }
        //if we did find a num, prev's next to be the currentNode's next
        //keep looking until we reach the tail
    }
}

let nums = [1,2,3,4,4,5]
var ll = TLinkedList<TNode<Int>>()
var prevNode: TNode<Int>? = nil
for num in nums {
    let node = TNode.init(value: num, next: prevNode)
    ll.append(node)
    prevNode = node
}
ll.displayListItems()
print("\n=================")
let node = TNode.init(value: 3)
ll.displayListItems()

