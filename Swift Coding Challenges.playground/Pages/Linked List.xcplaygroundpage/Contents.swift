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
        }
        
        var current = head
        while current?.next != nil { //while we are not at the tail
            current = current?.next
        }
        current?.next = Node(value: value, next: nil) //once we are at the tail, we will create a new node that the tail will be pointing to
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

let list = LinkedList()
list.insert(value: 1)
list.insert(value: 2)
list.insert(value: 3)
list.insert(value: 4)
list.insert(value: 5)






list.displayListItems()

//: [Next](@next)
