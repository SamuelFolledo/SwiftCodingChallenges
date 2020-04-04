//: [Previous](@previous)

import Foundation

class Solution {
//Day 2 Homework
    //https://leetcode.com/problems/add-two-numbers/
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    ///Add the two numbers and return it as a linked list.
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var ll: ListNode = ListNode(l1!.val + l2!.val)
        //Initialize current to head
        var current1: ListNode? = l1!.next
        var current2: ListNode? = l2!.next
        //loop till current not equal to None
        while current1 != nil || current2 != nil {
            ll.next = ListNode(current1!.val + current2!.val)
            ll = ll.next!
            current1 = current1!.next
            current2 = current2!.next
        }
        return ll
    }
}

//: [Next](@next)
