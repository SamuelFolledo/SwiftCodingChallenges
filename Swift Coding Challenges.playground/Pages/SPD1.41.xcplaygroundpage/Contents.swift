//: [Previous](@previous)

import Foundation


//Day 2 Homework
//https://leetcode.com/problems/add-two-numbers/
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    func displayListItems() {
        print("Here is what's inside your list")
        var current: ListNode? = self
        while current != nil { //will iterate until reaching tail when next is nil
            print(current!.val,"-->")
            current = current!.next
        }
    }
}

///Add the two numbers and return it as a linked list.
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let l1 = l1 else { return l2 }
    guard let l2 = l2 else { return l1 }
    let val = l1.val + l2.val
    if val < 10 { //if val less than 10, then go to the next
        let ansNode = ListNode(val)
        ansNode.next = addTwoNumbers(l1.next, l2.next) //recursive next to ansNode
        return ansNode
    } else { //handle carry by subtrating 10 to get remainder
        let rval = l1.val + l2.val-10
        let ansNode = ListNode(rval)
        ansNode.next = addTwoNumbers(ListNode(1), addTwoNumbers(l1.next, l2.next)) //advanced recursion
        return ansNode
    }
}

var l1 = ListNode(2)
var newNode = ListNode(4)
l1.next = newNode
newNode = ListNode(3)
l1.next!.next = newNode

var l2 = ListNode(5)
newNode = ListNode(6)
l2.next = newNode
newNode = ListNode(4)
l2.next!.next = newNode

//l1.displayListItems()
//l2.displayListItems()

var l3 = addTwoNumbers(l1, l2)
l3?.displayListItems()

//: [Next](@next)
