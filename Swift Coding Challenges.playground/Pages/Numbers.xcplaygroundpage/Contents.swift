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

//: [Next](@next)
