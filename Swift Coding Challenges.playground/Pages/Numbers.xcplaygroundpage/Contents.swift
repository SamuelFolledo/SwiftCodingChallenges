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


/*: ## Challenge 16: Fizz Buzz

Difficulty: Easy
 Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.
 Sample input and output
 
• 1 should print “1”
 
• 2 should print “2”
 
• 3 should print “Fizz”
 
• 4 should print “4”
 
• 5 should print “Buzz”
 
• 15 should print “Fizz Buzz”
 
#### Hints
Hint #1: You’ll need to use modulus: %.
 
Hint #2: Check for the “Fizz Buzz” case first, because that’s most specific.
 
Hint #3: Remember to use the closed range operator to include the number 100 at the end.
*/

func challenge16() {
    for num in 1...100 {
        if num % 3 == 0 && num % 5 == 0 {
            print("Fizz Buzz")
        } else if num % 3 == 0 {
            print("Fizz")
        } else if num % 5 == 0 {
            print("Buzz")
        } else {
            print(num)
        }
    }
}
//challenge16()

//slightly more efficient as we are not evaluating num % 3 twice
func challenge16b() {
    for i in 1...100 {
        if i % 3 == 0 {
            if i % 5 == 0 {
                print("Fizz Buzz")
            } else {
                print("Fizz")
            }
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

/*: ## Challenge 17: Generate a random number in a range
Difficulty: Easy
Write a function that accepts positive minimum and maximum integers, and returns a random number between those two bounds, inclusive.
 #### Hints
 
 Hint #1: There are lots of ways to generate random numbers in Swift; you’ll be judged –  silently or openly – on your choice.
 
 Hint #2: Keep in mind that lots of random number generators generate from 0 up to a certain point so you’ll need to write code to count from an arbitrary number upwards.
 
 Hint #3: Also remember that lots of random number generators generate up to but excluding the maximum, so you should add 1 to make sure your tests pass.
 
 Hint #4: Take a look at ```arc4random_uniform().```
        - ```arc4random_uniform().``` generates numbers from 0 up to an upper bound, it excludes the upper bound rather than including it, and it uses UInt32 rather than Int, so you need some typecasting.

*/


func challenge17(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}


/*: ## Challenge 18: Recreate the pow() function
 
 Difficulty: Easy
 Create a function that accepts positive two integers, and raises the first to the power of the second.
 Tip: If you name your function myPow() or challenge18(), you’ll be able to use the built-in pow() for your tests. The built-in pow() uses doubles, so you’ll need to typecast.
 Sample input and output
 
 • The inputs 4 and 3 should return 64, i.e. 4 multiplied by itself 3 times.
 
 • The inputs 2 and 8 should return 256, i.e. 2 multiplied by itself 8 times.
 
 ### Hints
 
 Hint #1: You don’t need any hints to solve this one.
 
 Hint #2: Oh, alright: here’s a hint: you can either use a loop or, if you’re feeling fancy, use a recursive function.
 
 Hint #3: Here’s another: you could use guard or precondition() to ensure both numbers are positive.

 */
func challenge18a(number: Int, power: Int) -> Int {
    guard number > 0, power > 0 else { return 0 }
    var returnValue = number
    for _ in 1..<power {
        returnValue *= number
    }
    return returnValue
}

func challenge18b(number: Int, power: Int) -> Int {
    guard number > 0, power > 0 else { return 0 }
    if power == 1 { return number }
    return number * challenge18b(number: number, power: power - 1)
}

/*: ## Challenge 19: Swap two numbers
 Difficulty: Easy
 Swap two positive variable integers,  a and b, without using a temporary variable.
 Sample input and output
 
 • Before running your code a should be 1 and b should be 2; afterwards, b should be 1
 and a should be 2.
 
 ### Hints
 Hint #1: There are lots of ways to solve this, but probably the easiest to remember is using tuples.
 
 Hint #2: Alternatively, try using the global Swift function swap().
 
 Hint #3: If you’re feeling fancy, you can solve this problem with arithmetic.
 
 Hint #4: If you’re feeling fancy and want to demonstrate your bit manipulation skills, you can also solve this problem using bitwise XOR.


*/


/* ## Challenge 20: Number is prime


*/

/* ## Challenge 21: Counting binary ones


*/

/* ## Challenge 22: Binary reverse


*/

/* ## Challenge 23: Integer disguised as string


*/

/* ## Challenge 24: Add numbers inside a string


*/

/* ## Challenge 25: Calculate a square root by hand


*/


/* ## Challenge 26: Subtract without subtract
 
*/


//: [Next](@next)
