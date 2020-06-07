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
// Solution 1
var a = 2
var b = 3
a=a+b
b=a-b
a=a-b

// Solution 2 XOR
a=a^b
b=a^b
a=a^b

// Solution 3 global swap function
swap(&a, &b)

// Solution 4 tuples
(a, b) = (b, a)

/*: ## Challenge 20: Number is prime
 
 Difficulty: Tricky
 Write a function that accepts an integer as its parameter and returns true if the number is prime.
 Tip: A number is considered prime if it is greater than one and has no positive divisors other than 1 and itself.
 
 Sample input and output
 • The number 11 should return true.
 • The number 9 should return false.
 • The number 16777259 should return true.
 
 ### Hints
 
 Hint #1: You should start with a brute force approach: loop through every number from 2 up to one less than the input number, and check whether the input number divides into it.
 
 Hint #2: You can shrink the search space by searching up to a smaller number – what’s the highest it could be?
 
 Hint #3: There’s no point searching higher than the square root of your input number, rounding up.
*/

func challenge20a(number: Int) -> Bool { //naive solution
    guard number >= 2 else { return false } //make sure it is greater than 2
    for i in 2 ..< number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func challenge20b(number: Int) -> Bool {
    guard number >= 2 else { return false }
    guard number != 2 else { return true }
    let max = Int(ceil(sqrt(Double(number))))
    for i in 2 ... max {
        if number % i == 0 {
            return false
        }
    }
    return true
}

/*: ## Challenge 21: Counting binary ones

 Difficulty: Tricky
 
 Create a function that accepts any positive integer and returns the next highest and next lowest number that has the same number of ones in its binary representation. If either number is not possible, return nil for it.
 ### Sample input and output
 -  The number 12 is 1100 in binary, so it has two 1s. The next highest number with that
 many 1s is 17, which is 10001. The next lowest is 10, which is 1010.
 - The number 28 is 11100 in binary, so it has three 1s. The next highest number with that many 1s is 35, which is 100011. The next lowest is 26, which is 11010.
 
 ### Hints
 Hint #1: You can find the binary representation of an integer by converting it to a string – look for a “radix” initializer.
 
 Hint #2: You should be using radix 2, which is binary. Hint #3: Your return value ought to be (nextHighest: Int?, nextLowest: Int?). Hint #4: You can count the 1s in a stringified number by using filter() on its letters property.
 
 Hint #5: Don’t be afraid to duplicate code while you’re working – you need to search up and down for the same thing, so start with duplication then refactor.
 
 Hint #6: You can’t create ranges where the end is higher than the start. Instead, create a forwards range then reverse it.
*/

func challenge21(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    let targetBinary = String(number, radix: 2)
    let targetOnes = targetBinary.filter { (char: Character) -> Bool in char == "1" }.count
    var nextHighest: Int? = nil
    var nextLowest: Int? = nil
    for i in number + 1...Int.max {
        let currentBinary = String(i, radix: 2)
        let currentOnes = currentBinary.filter { (char: Character) -> Bool in char == "1" }.count
        if targetOnes == currentOnes {
            nextHighest = i
            break
        }
    }
    for i in (0 ..< number).reversed() {
        let currentBinary = String(i, radix: 2)
        let currentOnes = currentBinary.filter { (char: Character) -> Bool in char == "1" }.count
        if targetOnes == currentOnes {
            nextLowest = i
            break
        }
    }
    return (nextHighest, nextLowest)
}

func challenge21b(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    func ones(in number: Int) -> Int {
        let currentBinary = String(number, radix: 2)
        return currentBinary.filter { (char: Character) -> Bool in char == "1" }.count
    }
    let targetOnes = ones(in: number)
    var nextHighest: Int? = nil
    var nextLowest: Int? = nil
    for i in number + 1...Int.max {
        if ones(in: i) == targetOnes {
            nextHighest = i
            break
        }
    }
    for i in (0 ..< number).reversed() {
        if ones(in: i) == targetOnes {
            nextLowest = i
            break
        }
    }
    return (nextHighest, nextLowest)
}



/*: ## Challenge 22: Binary reverse
 
 Difficulty: Tricky
 Create a function that accepts an unsigned 8-bit integer and returns its binary reverse, padded so that it holds precisely eight binary digits.
 Tip: When you get the binary representation of a number, Swift will always use as few bits as possible – make sure you pad to eight binary digits before reversing.
 ### Sample input and output
 - The number 32 is 100000 in binary, and padded to eight binary digits that’s 00100000.
 Reversing that binary sequence gives 00000100, which is 4. So, when given the input 32 your function should return 4.
 - The number 41 is 101001 in binary, and padded to eight binary digits that 00101001.
 Reversing that binary sequence gives 10010100, which is 148. So, when given the input 41 your function should return 148.
 - It should go without saying that your function should be symmetrical: when fed 4 it
 should return 32, and when fed 148 it should return 41.
 
 ### Hints
 Hint #1: You can get the binary representation of an integer using String(someNumber, radix: 2).
 
 Hint #2: You can get the decimal integer equivalent of a string containing binary using Int(someString, radix: 2) – but be warned that will given you an optional integer.
 
 Hint #3: To pad the input number’s binary representation so that it holds eight digits, use the String(repeating:count:) initializer.
 
 Hint #4: You can reverse a character array then create a new string from it.


*/

func challenge22(number: UInt) -> UInt {
    let binary = String(number, radix: 2) //convert num to binary
    let paddingAmount = 8 - binary.count //get missing 0s count
    let paddedBinary = String(repeating: "0", count: paddingAmount) + binary //append the missing 0s to binary
    let reversedBinary = String(paddedBinary.reversed()) //reverse it
    return UInt(reversedBinary, radix: 2)! //convert binary back to number
}


/*: ## Challenge 23: Integer disguised as string
 Difficulty: Tricky
 Write a function that accepts a string and returns true if it contains only numbers, i.e. the digits 0 through 9.
 ### Sample input and output
 - The input “01010101” should return true.
 - The input “123456789” should return true.
 - The letter “9223372036854775808” should return true.
 - The letter “1.01” should return false; “.” is not a number.
 
 ### Hints
 Hint #1: You can create integers from strings, and Swift will return nil if the conversion failed.
 
 Hint #2: The number “9223372036854775808” is a precise choice, not just a random string of numbers.
 
 Hint #3: Chances are Swift’s integer type will be 64-bit for you, and it’s signed, which means its maximum value is 2 to the power of 63, minus 1, i.e. 9223372036854775807 – that’s one less than the test case you’ve been given.
 
 Hint #4: You should look into inverted character sets.
 
 Hint #5: Some languages write numbers differently from English.


*/
func challenge23a(input: String) -> Bool {
    return UInt(input) != nil //use UInt because the ceiling of Int is 9,223,372,036,854,775,807 so having an input bigger than that will fail
    //However, all unsigned integers do is double the largest number you can address, so this would still fail if I add 0 at the end
}
print("Challenge 23a:", challenge23a(input: "9223372036854775807"))

func challenge23b(input: String) -> Bool { //good solution
    for letter in input {
        if Int(String(letter)) == nil {
            return false
        }
    }
    return true
}

func challenge23c(input: String) -> Bool {
    return input.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
}

func challenge23d(input: String) -> Bool {
    return input.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789").inverted) == nil
}



/*: ## Challenge 24: Add numbers inside a string
 Difficulty: Tricky
 Given a string that contains both letters and numbers, write a function that pulls out all the numbers then returns their sum.
 ### Sample input and output
 - The string “a1b2c3” should return 6 (1 + 2 + 3).
 - The string “a10b20c30” should return 60 (10 + 20 + 30).
 - The string “h8ers” should return “8”.
 
 ### Hints
 
 Hint #1: Creating an integer from a string returns Int? – nil if it was a number, or an Int otherwise.
 
 Hint #2: Use the nil coalescing operator, ??, to strip out any unwanted optionality.
 
 Hint #3: Don’t forget to catch trailing numbers, i.e. where the string ends with a number.
 Hint #4: You could solve this using regular expressions, in which case I’d grade it as taxing rather than tricky.
*/

func challenge24a(string: String) -> Int {
    var currentNumber = ""
    var sum = 0
    for letter in string {
        let strLetter = String(letter)
        if Int(strLetter) != nil {
            currentNumber += strLetter
        } else {
            sum += Int(currentNumber) ?? 0
            currentNumber = "" //reset current number
        }
    }
    sum += Int(currentNumber) ?? 0 //add last currentNumber
    return sum
}

print("Challenge 24a: \(challenge24a(string: "aj22-jf99=1"))")

func challenge24b(string: String) -> Int {
    let regex = try! NSRegularExpression(pattern: "(\\d+)", options: [])
    let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
    let allNumbers = matches.compactMap { //create an array of numbers from matches
        Int((string as NSString).substring(with: $0.range))
    }
    return allNumbers.reduce(0, +)
}

print("Challenge 24b: \(challenge24b(string: "aj22-jf99=1"))")

/*: ## Challenge 25: Calculate a square root by hand
 Difficulty: Taxing
 Write a function that returns the square root of a positive integer, rounded down to the nearest integer, without using sqrt().
 ### Sample input and output
 - The number 9 should return 3.
 
 - The number 16777216 should return 4096.
 
 - The number 16 should return 4.
 
 - The number 15 should return 3.
 
 ### Hints
 Hint #1: You can brute force this using a loop count from 0 up to the input number.
 
 Hint #2: A more efficient solution is using a binary search.
 
 Hint #3: A rounded-down integer square root will never be more than half its square.
 
 Hint #4: If you consider half your input number to be your upper bound, then calculate the mid-point between that and a lower bound that’s initially 0 (i.e., input number / 4), you can check whether that mid-point squared gives your input.
 
 Hint #5: If the mid-point is too low, make it the new lower bound then repeat. If the mid-point is too high, make it the new higher bound then repeat.
 
 Hint #6: Using this technique, you should be able to loop until you find the best answer.


*/

func challenge25a(input: Int) -> Int {
    guard input != 1 else { return 1 }
    for i in 0 ... input / 2 + 1 {
        if i * i > input {
            return i - 1
        }
    }
    return 0
}

func challenge19b(input: Int) -> Int {
    guard input != 1 else { return 1 }
    var lowerBound = 0
    var upperBound = 1 + input / 2
    while lowerBound + 1 < upperBound {
        let middle = lowerBound + ((upperBound - lowerBound) / 2)
        let middleSquared = middle * middle
        if middleSquared == input {
            return middle
        } else if middleSquared < input {
            lowerBound = middle
            
        } else {
            upperBound = middle
            
        }
    }
    return lowerBound
}

func challenge25c(input: Int) -> Int {
    return Int(floor(pow(Double(input), 0.5)))
}

/*: ## Challenge 26: Subtract without subtract
 Difficulty: Taxing
 Create a function that subtracts one positive integer from another, without using -.
 ### Sample input and output
 - The code challenge26(subtract: 5, from: 9) should return 4.
 - The code challenge26(subtract: 10, from: 30) should return 20.
 ### Hints
 Hint #1: In your code you can use any other operator, or any other number, positive or negative, just not the - operator.
 
 Hint #2: Swift has a full set of bitwise operators – operators that manipulate the binary digits of a number.
 
 Hint #3: You could try using bitwise NOT, which is ~.

*/
func challenge26a(subtract: Int, from: Int) -> Int {
    return from + -subtract
} //Technically, though, - in that instance is the unary minus operator, so it’s the same thing


//: [Next](@next)
