//: [Previous](@previous)

import Foundation

/*
 ## [2D Array - Max Hourglass Sum](https://www.hackerrank.com/challenges/2d-array/problem)
 Given a 6x6 2D Array *arr*, which has 16 hourglasses, calculate the hourglass sum for every hourglass in *arr*, then print the maximum hourglass sum
 */

func hourglassSum(arr: [[Int]]) -> Int {
    func getHourglass(row: Int, column: Int) -> [Int] {
        return [arr[row][column], arr[row][column+1], arr[row][column+2],
                arr[row+1][column+1],
                arr[row+2][column], arr[row+2][column+1], arr[row+2][column+2],
        ]
    }
    
    var maxSum = Int.min
    // Write your code here
    for row in 0..<arr.count - 2 {
        for column in 0..<arr[row].count - 2 {
            let hourglass = getHourglass(row: row, column: column)
            let total = hourglass.reduce(0){$0+$1}
//            print("Hourglass \(row), \(column): \(hourglass) = \(total)")
            if total > maxSum {
                maxSum = total
            }
        }
    }
    return maxSum
}

let arr = [[-9, -9, -9, 1, 1, 1],
           [0, -9, 0, 4, 3, 2],
           [-9, -9, -9, 1, 2, 3],
           [0, 0, 8, 6, 6, 0],
           [0, 0, 0, -2, 0, 0],
           [0, 0, 1, 2, 4, 0,]]
print("Hourglass Max Sum = ", hourglassSum(arr: arr))

/*:
 ## Two Strings
 Given two strings, determine if they share a common substring. A substring may be as small as one character.

 ### Example
 ```
 s1 = 'and'
 s2 = 'art'
 ```
 
 These share the common substring *a*.
 
 
 ```
 s1 = 'be'
 s2 = 'cat'
 ```

 These do not share a substring.
 
 ### Output Format

 For each pair of strings, return YES or NO.

 ### Sample Input
 ```
 2
 hello
 world
 hi
 world
 ```
 ### Sample Output
 YES
 
 NO
 ### Explanation

 We have p = 2 pairs to check:
 1. s1 = "hello", s2 = world". The substrings  and  are common to both strings.
 2. a= "hi", b = "world". s1 and s2  share no common substrings.
 */

func twoStrings(s1: String, s2: String) -> String {
    var s1Dic = [String: Int]()
    for letter in s1 {
        s1Dic[String(letter)] = 0
    }
    for letter in s2 {
        if let _ = s1Dic[String(letter)] {
//            s1Dic[String(letter)]! += 1
            return "YES"
        }
    }
//    for value in s1Dic.values {
//        if value > 0 {
//            return "YES"
//        }
//    }
    return "NO"
}

let s1 = "hello"
let s2 = "world"
print("Two Strings for s1 \(s1) and s2 \(s2) = \(twoStrings(s1: s1, s2: s2))")

//: [Next](@next)
