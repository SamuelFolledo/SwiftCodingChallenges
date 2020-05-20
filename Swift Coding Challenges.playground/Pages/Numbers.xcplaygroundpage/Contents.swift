//: [Previous](@previous)

import Foundation

//Given an array of sorted integers, return the array of integers squared still sorted.

//Examples:
//[1,2,3] -> [1,4,9]
//[-1, 0, 1] -> [0, 1, 1]
//[-5, -3, 1, 2] -> [1, 4, 9, 25]

func bubbleSortArray(arr: [Int]) -> [Int] {
    var results: [Int] = []
    for num in arr {
        results.append(num*num)
    }
    var isSorted = false
    var temp = 0
    while !isSorted { //bubble sort
        isSorted = true
        for i in 0..<results.count - 1 {
            if (results[i] > results[i+1]) {
                temp = results[i]
                results[i] = results[i+1]
                results[i+1] = temp
                isSorted = false
            }
        }
    }
    print("Bubble sort array = \(results)")
    return results
}

bubbleSortArray(arr: [-5, -3, -1, 0, 1, 2])


import UIKit
//: Chellenge 52
protocol Numeric { //First, creating a new protocol that requires conforming types to be able to initialize themselves with an empty value (i.e. 0) and add instances of itself to itself:
    init()
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: Numeric {} //make Int, Float, and Double conform to that protocol:
extension Float: Numeric {}
extension Double: Numeric {}

func sumArray<T: Numeric>(numbers: [T]) -> T { //Third, defining a function that accepts an array of numbers that conform to Numeric and returns a single value. //<T: Numeric> is required whenever you use generics as parameter
    var total = T()
    
    for num in numbers {
        total = total + num
    }
    
    return total
}

print(sumArray(numbers: [1,2,3.901919,4,5,6,8.0]))
print(sumArray(numbers: [1,4,3,6,5,6,8.0]))
print(sumArray(numbers: [1,7,2.3,4.099,9,6,11.3]))


import Accelerate //faster for slower

func challenge52c(numbers: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_sveD(numbers, 1, &result, vDSP_Length(numbers.count))
    return result
}


//CHALLENGE 16: Fizz Buzz
//Difficulty: Easy
//Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.
//Sample input and output
//• 1 should print “1”
//• 2 should print “2”
//• 3 should print “Fizz”
//• 4 should print “4”
//• 5 should print “Buzz”
//• 15 should print “Fizz Buzz”
/*Hints
 Hint #1: You’ll need to use modulus: %.
 Hint #2: Check for the “Fizz Buzz” case first, because that’s most specific.
 Hint #3: Remember to use the closed range operator to include the number 100 at the end.
*/


//: [Next](@next)
