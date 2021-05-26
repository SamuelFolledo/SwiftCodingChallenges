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
    return true
}

/*
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
    return 0
}

/*
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

//: [Next](@next)
