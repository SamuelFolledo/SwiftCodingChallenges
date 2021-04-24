//: [Previous](@previous)

import Foundation

public func solution(_ S : inout String) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var stack = Stack()
    let words = S.components(separatedBy: " ")
    for word in words {
        if let number = Int(word) {
            stack.push(number)
        } else { //operation
            switch word {
            case "+":
                if stack.hasLessThanTwoElements() {
                    fatalError("Error: There is only one number on the stack.")
                }
                let firstNum = stack.pop()!
                let secondNum = stack.pop()!
                let total = firstNum + secondNum
                stack.push(total)
            case "-":
                if stack.hasLessThanTwoElements() {
                    fatalError("Error: There is only one number on the stack.")
                }
                let firstNum = stack.pop()!
                let secondNum = stack.pop()!
                let difference = firstNum - secondNum
                stack.push(difference)
            case "DUP":
                if stack.peek() == nil {
                    fatalError("Error: No number to duplicate")
                }
                stack.push(stack.peek()!)
            case "POP":
                if stack.peek() == nil {
                    fatalError("Error: No number to pop")
                }
                stack.pop()
            default:
                fatalError("Unknown operation")
            }
        }
    }
    return stack.peek()!
}

enum StackError: Error {
    case isEmpty, isLessThanTwo, isNegative, unknownOperation
}

struct Stack {
    private var array: [Int] = []
    
    mutating func push(_ element: Int) {
        // 2
        array.append(element)
    }
    
    mutating func pop() -> Int? {
        // 2
        if array.isEmpty { return nil }
        return array.popLast()
    }
    
    func peek() -> Int? {
        return array.last
    }
    
    func hasLessThanTwoElements() -> Bool {
        return array.count < 2
    }
}

var S = "4 5 6 - 7 +"
print(solution(&S))

//: [Next](@next)
