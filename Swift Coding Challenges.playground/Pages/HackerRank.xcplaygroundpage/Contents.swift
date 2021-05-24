//: [Previous](@previous)

import Foundation

/*
 ## [2D Array - Max Hourglass Sum](https://www.hackerrank.com/challenges/2d-array/problem)
 Given a 6x6 2D Array *arr*, which has 16 hourglasses, calculate the hourglass sum for every hourglass in *arr*, then print the maximum hourglass sum
 */

func hourglassSum(arr: [[Int]]) -> Int {
    func getHourglass(row: Int, column: Int) -> [Int] {
        let start = arr[row][column]
        return [arr[row][column], arr[row][column+1], arr[row][column+2],
                arr[row+1][column+1],
                arr[row+2][column], arr[row+2][column+1], arr[row+2][column+2],
        ]
    }
    
    let maxSum = 0
    // Write your code here
    for row in arr.count - 2 {
        for column in arr[row].count - 2 {
            let hourglass = getHourglass(row: row, column: column)
            print("Hourglass \(row), \(column) = \(hourglass)")
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
print(hourglassSum(arr: arr))

//: [Next](@next)
