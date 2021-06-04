//: [Previous](@previous)

import Foundation
import UIKit

/*:
 ## 1812. [Determine Color of a Chessboard Square](https://leetcode.com/problems/determine-color-of-a-chessboard-square/)
 You are given coordinates, a string that represents the coordinates of a square of the chessboard. Return true if the square is white, and false if the square is black.

 The coordinate will always represent a valid chessboard square. The coordinate will always have the letter first, and the number second.

 #### Example 1:
 Input: coordinates = "a1"
 Output: false
 Explanation: From the chessboard above, the square with coordinates "a1" is black, so return false.
 
 #### Example 2:

 Input: coordinates = "h3"
 Output: true
 Explanation: From the chessboard above, the square with coordinates "h3" is white, so return true.
 
 #### Example 3:

 Input: coordinates = "c7"
 Output: false
  
 #### Constraints:
 - coordinates.length == 2
 - 'a' <= coordinates[0] <= 'h'
 - '1' <= coordinates[1] <= '8'
 */

func squareIsWhite(_ coordinates: String) -> Bool {
    let letters: [String] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    var isWhite = false
    for num in 1...8 {
        for letter in letters {
            if "\(letter)\(num)" == coordinates {
                return isWhite
            }
            isWhite = !isWhite
        }
        isWhite = !isWhite
    }
    return false
}
let coordinates = "a1"
print("Chessboard: at \(coordinates) is white = \(squareIsWhite(coordinates))")

/*:
 ## 1464. [Maximum Product of Two Elements in an Array](https://leetcode.com/problems/maximum-product-of-two-elements-in-an-array/)
 
 Given the array of integers nums, you will choose two different indices i and j of that array. *Return the maximum value of* `(nums[i]-1)*(nums[j]-1)`.
  

 #### Example 1:
 Input: nums = [3,4,5,2]
 Output: 12
 Explanation: If you choose the indices i=1 and j=2 (indexed from 0), you will get the maximum value, that is, (nums[1]-1)*(nums[2]-1) = (4-1)*(5-1) = 3*4 = 12.
 
 #### Example 2:
 Input: nums = [1,5,4,5]
 Output: 16
 Explanation: Choosing the indices i=1 and j=3 (indexed from 0), you will get the maximum value of (5-1)*(5-1) = 16.
 
 #### Example 3:
 Input: nums = [3,7]
 Output: 12
  
 #### Constraints:
 - 2 <= nums.length <= 500
 - 1 <= nums[i] <= 10^3
 */

func maxProduct(_ nums: [Int]) -> Int {
    var maxProduct = Int.min
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            let product = (nums[i] - 1) * (nums[j] - 1)
            if maxProduct < product {
                maxProduct = product
            }
        }
    }
    return maxProduct
}

print("Max Product \(maxProduct([3,7,8,6]))")

/*:
 ## 1304. [Find N Unique Integers Sum up to Zero](https://leetcode.com/problems/find-n-unique-integers-sum-up-to-zero/)
 
 Given an integer n, return any array containing n unique integers such that they add up to 0.

 #### Example 1:
 Input: n = 5
 Output: [-7,-1,1,3,4]
 Explanation: These arrays also are accepted [-5,-1,1,2,3] , [-3,-1,2,-2,4].
 
 #### Example 2:
 Input: n = 3
 Output: [-1,0,1]
 
 #### Example 3:
 Input: n = 1
 Output: [0]
  
 #### Constraints:
 - 1 <= n <= 1000
 */

func sumZero(_ n: Int) -> [Int] {
    var results: [Int] = n % 2 == 0 ? [] : [0] //empty array or add 0 if n is odd
    for i in 1...n {
        results.append(i)
        results.append(i * -1)
        if results.count == n {
            return results
        }
    }
    return results
}

print("Sum Zero = \(sumZero(5))")

/*:
 ## 617. [Merge Two Binary Trees](https://leetcode.com/problems/merge-two-binary-trees/)
 Easy

 You are given two binary trees root1 and root2.

 Imagine that when you put one of them to cover the other, some nodes of the two trees are overlapped while the others are not. You need to merge the two trees into a new binary tree. The merge rule is that if two nodes overlap, then sum node values up as the new value of the merged node. Otherwise, the NOT null node will be used as the node of the new tree.

 Return the merged tree.

 Note: The merging process must start from the root nodes of both trees.
 Example 1:
 - Input: root1 = [1,3,2,5], root2 = [2,1,3,null,4,null,7]
 - Output: [3,4,5,5,4,null,7]
 
 Example 2:
 - Input: root1 = [1], root2 = [1,2]
 - Output: [2,2]

 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
    return nil
}

/*:
 ## [1572. Matrix Diagonal Sum](https://leetcode.com/problems/matrix-diagonal-sum/)
 Given a square matrix mat, return the sum of the matrix diagonals.

 Only include the sum of all the elements on the primary diagonal and all the elements on the secondary diagonal that are not part of the primary diagonal.


 #### Example 1:
 - Input: mat = [[1,2,3],
               [4,5,6],
               [7,8,9]]
 - Output: 25
 - Explanation: Diagonals sum: 1 + 5 + 9 + 3 + 7 = 25
 - Notice that element mat[1][1] = 5 is counted only once.
 
 #### Example 2:
 - Input: mat = [[1,1,1,1],
               [1,1,1,1],
               [1,1,1,1],
               [1,1,1,1]]
 - Output: 8
 
 #### Example 3:
 - Input: mat = [[5]]
 - Output: 5
  
 #### Constraints:
 - n == mat.length == mat[i].length
 - 1 <= n <= 100
 - 1 <= mat[i][j] <= 100
 */

func diagonalSum(_ mat: [[Int]]) -> Int {
    var sum = 0
    let matCount = mat.count
    var half = matCount / 2
    if matCount % 2 == 0 { //if matCount is even
        half -= 1
    }
    for rowIndex in 0...half {
        for columnIndex in rowIndex...half {
            let lastRowIndex = matCount - 1 - rowIndex
            if rowIndex == lastRowIndex { //if middle
                sum += mat[rowIndex][columnIndex] //increment once
            } else {
                let lastColumnIndex = matCount - 1 - columnIndex
                sum += mat[rowIndex][columnIndex]
                sum += mat[rowIndex][lastColumnIndex]
                sum += mat[lastRowIndex][columnIndex]
                sum += mat[lastRowIndex][lastColumnIndex]
            }
            break
        }
    }
    return sum
}

let mat1 = [[1,2,3], [4,5,6], [7,8,9]]
let mat2 = [[1,1,1,1], [1,1,1,1], [1,1,1,1], [1,1,1,1]]
print("Diagonal Sum for \(mat1) = \(diagonalSum(mat1))")
print("Diagonal Sum for \(mat2) = \(diagonalSum(mat2))")
/*:
 ## [1450. Number of Students Doing Homework at a Given Time](https://leetcode.com/problems/number-of-students-doing-homework-at-a-given-time/)

 Given two integer arrays startTime and endTime and given an integer queryTime.

 The ith student started doing their homework at the time startTime[i] and finished it at time endTime[i].

 Return the number of students doing their homework at time queryTime. More formally, return the number of students where queryTime lays in the interval [startTime[i], endTime[i]] inclusive.

 #### Example 1:
 - Input: startTime = [1,2,3], endTime = [3,2,7], queryTime = 4
 - Output: 1
 - Explanation: We have 3 students where:
    - The first student started doing homework at time 1 and finished at time 3 and wasn't doing anything at time 4.
    - The second student started doing homework at time 2 and finished at time 2 and also wasn't doing anything at time 4.
    - The third student started doing homework at time 3 and finished at time 7 and was the only student doing homework at time 4.
 
 #### Example 2:
 - Input: startTime = [4], endTime = [4], queryTime = 4
 - Output: 1
 - Explanation: The only student was doing their homework at the queryTime.
 
 #### Example 3:
 - Input: startTime = [4], endTime = [4], queryTime = 5
 - Output: 0
 
 #### Example 4:
 - Input: startTime = [1,1,1,1], endTime = [1,3,2,4], queryTime = 7
 - Output: 0
 
 #### Example 5:
 - Input: startTime = [9,8,7,6,5,4,3,2,1], endTime = [10,10,10,10,10,10,10,10,10], queryTime = 5
 - Output: 5
  
 #### Constraints:
 - startTime.length == endTime.length
 - 1 <= startTime.length <= 100
 - 1 <= startTime[i] <= endTime[i] <= 1000
 - 1 <= queryTime <= 1000
 */

func busyStudent(_ startTime: [Int], _ endTime: [Int], _ queryTime: Int) -> Int {
    var busyStudentCounter = 0
    for i in 0..<startTime.count {
        let start = startTime[i]
        let end = endTime[i]
        switch queryTime {
        case start...end: //if queryTime is between start - end, increment busy student
            busyStudentCounter += 1
        default:
             break
        }
    }
    return busyStudentCounter
}

/*:
 ## [1844. Replace All Digits with Characters](https://leetcode.com/problems/replace-all-digits-with-characters/)
 
 You are given a 0-indexed string s that has lowercase English letters in its even indices and digits in its odd indices.

 There is a function shift(c, x), where c is a character and x is a digit, that returns the xth character after c.

 For example, shift('a', 5) = 'f' and shift('x', 0) = 'x'.
 For every odd index i, you want to replace the digit s[i] with shift(s[i-1], s[i]).

 Return s after replacing all digits. It is guaranteed that shift(s[i-1], s[i]) will never exceed 'z'.

 #### Example 1:
 - Input: s = "a1c1e1"
 - Output: "abcdef"
 - Explanation: The digits are replaced as follows:
    - s[1] -> shift('a',1) = 'b'
    - s[3] -> shift('c',1) = 'd'
    - s[5] -> shift('e',1) = 'f'
 
 #### Example 2:
 - Input: s = "a1b2c3d4e"
 - Output: "abbdcfdhe"
 - Explanation: The digits are replaced as follows:
    - s[1] -> shift('a',1) = 'b'
    - s[3] -> shift('b',2) = 'd'
    - s[5] -> shift('c',3) = 'f'
    - s[7] -> shift('d',4) = 'h'

 #### Constraints:
 - 1 <= s.length <= 100
 - s consists only of lowercase English letters and digits.
 - shift(s[i-1], s[i]) <= 'z' for all odd indices i.
 */

func replaceDigits(_ s: String) -> String {
    if s.count == 1 { return s }
    let alphabets = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    var result = ""
    for (index, value) in s.enumerated() {
        if index % 2 == 1 { continue } //skip numbers (if index is odd, continue)
        let letter = String(value)
        result += letter
        if s.count - 1 == index { continue } //skip if letter was last
        let letterIndex = alphabets.firstIndex(of: String(letter)) //index of the letter in alphabets
        let number = s[s.index(s.startIndex, offsetBy: index + 1)] //get the letter (which is a number) at the right of the current letter
        let nextLetterIndex = Int(letterIndex!) + Int(String(number))! //add the letter's index in alphabet and the number at the right of the letter
        let nextLetter = alphabets[nextLetterIndex] //get the letter from the index
        result += nextLetter
    }
    return result
}

let stringToReplace = "a1b2c3d4e" //"a1c3e2"
print("Replace Digits: \(stringToReplace) = \(replaceDigits(stringToReplace))")

//: [Next](@next)
