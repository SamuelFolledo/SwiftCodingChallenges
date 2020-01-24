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

let list = LinkedList()
list.insert(value: 1)
list.insert(value: 2)
//list.insert(value: 3)
list.insert(value: 4)
list.insert(value: 5)

//list.delete(value: 5)
list.insertInOrder(value: 3)



list.displayListItems()

//: [Next](@next)
