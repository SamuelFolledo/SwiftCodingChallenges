//: [Previous](@previous)

/*:
 # Swift Coding Challenge's Section 5: Algorithms
 */

/*:
 ## Challenge 55: Bubble sort
 Difficulty: Easy
 
 Create an extension for arrays that sorts them using the bubble sort algorithm.
 
 Tip: A bubble sort repeatedly loops over the items in an array, comparing items that are next to each other and swapping them if they aren’t sorted. This looping continues until all items are in their correct order.
 ### Sample input and output
 - The array `[12, 5, 4, 9, 3, 2, 1]` should become `[1, 2, 3, 4, 5, 9, 12]`.
 - The array `["f", "a", "b"]` should become `["a", "b", "f"]`.
 - The array `[String]()` should become `[]`.
 ### Hints
 - Hint #1: You’ll need to extend the `Array` type, but only when its elements conform to `Comparable` so you can establish a sort order.
 - Hint #2: You want to repeat your loop while a condition is `true, so `repeat` while makes sense.
 - Hint #3: Watch out for the case when the array is empty.
 - Hint #4: You can swap two values using the global `swap()` function like this: `array.swapAt(a, b)`.
 - Hint #5: If you try printing out the array after each sorting pass you might spot a pattern that you can use to optimize your code.
 */
import Foundation

extension Array where Element: Comparable {
    func challenge55a() -> [Element] {
        // refuse to sort invalid arrays
        guard count > 1 else { return self }
        var returnValue = self
        var swapsMade: Bool
        repeat {
            // we're looping from scratch, so reset swapsMade to false
            swapsMade = false
            // loop over all items in the array, excluding the last one
            for index in 0 ..< returnValue.count - 1 {
                // pull out the current element and its successor
                let element = returnValue[index]
                let next = returnValue[index + 1]
                // if the current one is bigger than its successor…
                if (element > next) {
//                    print("Before \(returnValue)")
                    // swap them
                    returnValue.swapAt(index, index + 1)
                    // and mark that we made a swap so the loop will repeat
                    swapsMade = true
//                    print("After \(returnValue)")
                }
            }
        } while swapsMade == true
        // send back the sorted array
        return returnValue
    }
    
    func challenge55b() -> [Element] {
        //this is a better approach as it doesn't check the previous numbers that were already sorted
        guard count > 0 else { return [Element]() }
        var returnValue = self
        var highestSortedIndex = count
        repeat {
            var lastSwapIndex = 0
            for index in 0 ..< highestSortedIndex - 1 {
                let element = returnValue[index]
                let next = returnValue[index + 1]
                if (element > next) {
                    returnValue.swapAt(index, index + 1)
                    lastSwapIndex = index + 1
                }
            }
            highestSortedIndex = lastSwapIndex
            
        } while highestSortedIndex != 0
        return returnValue
    }
}

[12, 5, 4, 9, 3, 2, 1].challenge55a()

/*:
 ## Challenge 56: Insertion sort
 Difficulty: Easy
 
 Create an extension for arrays that sorts them using the insertion sort algorithm.
 
 **Tip**: An insertion sort creates a new, sorted array by removing items individually from the input array and placing them into the correct position in the new array.
 ### Sample input and output
 - The array `[12, 5, 4, 9, 3, 2, 1]` should become `[1, 2, 3, 4, 5, 9,
 12]`.
 - The array `["f", "a", "b"]` should become `["a", "b", "f"]`.
 - The array `[String]()` should become `[]`.
 ### Hints
 - Hint #1: You can perform insertion sort in-place, but that takes a little more thinking. Aim for correctness first, and efficiency later.
 - Hint #2: You will need to extend Array with a constraint on their elements so that they must be Comparable – that’s what lets us sort items.
 - Hint #3: In the most simple solution, you should be able to pick out an item from your source array, then search through your sorted destination array to find where it should go.
 - Hint #4: If you want to try the in-place solution, pull out the current item you want to sort, then keep moving other elements to the right until you find the correct spot for your item.
 */

extension Array where Element: Comparable {
    func challenge56a() -> [Element] {
        guard count > 1 else { return self }
        var returnValue = [Element]()
        for unsorted in self {
            if returnValue.count == 0 {
                returnValue.append(unsorted)
            } else {
                var placed = false
                for (index, sorted) in returnValue.enumerated() {
                    if unsorted < sorted {
                        returnValue.insert(unsorted, at: index)
                        placed = true
                        break
                    }
                }
                if !placed {
                    //if unsorted element never got inserted, append at the end
                    returnValue.append(unsorted)
                }
            }
        }
        return returnValue
    }
    
    func challenge56b() -> [Element] {
        guard count > 1 else { return self }
        var returnValue = self
        for i in 1 ..< count {
            var currentItemIndex = i
            // take a copy of the current item
            let itemToPlace = returnValue[currentItemIndex]
            // keep going around until we're at the start of the array or find an item that's greater or equal to us
            while currentItemIndex > 0 && itemToPlace < returnValue[currentItemIndex - 1] {
                // move this item to the right
                returnValue[currentItemIndex] = returnValue[currentItemIndex - 1]
                currentItemIndex -= 1
            }
            // place our item into its newly sorted place
            returnValue[currentItemIndex] = itemToPlace
        }
        return returnValue
    }
}

/*:
 ## Challenge 57: Isomorphic values
 Difficulty: Easy
 
 Write a function that accepts two values and returns true if they are isomorphic. That is, each part of the value must map to precisely one other, but that might be itself.
 
 Tip: Strings A and B are considered isomorphic if you can replace all instances of each letter with another. For example, “tort” and “pump” are isomorphic, because you can replace both Ts with a P, the O with a U, and the R with an M. For integers you compare individual digits, so 1231 and 4564 are isomorphic numbers. For arrays you compare elements, so [1, 2, 1] and [4, 8, 4] are isomorphic.
 ### Sample input and output These are all isomorphic values:
 - “clap” and “slap”
 - “rum” and “mud”
 - “pip” and “did”
 - “carry” and “baddy”
 - “cream” and “lapse”
 - 123123 and 456456
 - 3.14159 and 2.03048
 - [1, 2, 1, 2, 3] and [4, 5, 4, 5, 6]
 
 These are not isomorphic values:
 - “carry” and “daddy” – the Rs have become D, but C has also become D.
 - “did” and “cad” – the first D has become C, but the second has remained D.
 - “maim” and “same” – the first M has become S, but the second has become E.
 - “curry” and “flurry” – the strings have different lengths.
 - 112233 and 112211 – the number 1 is being mapped to 1, and the number 3 is also
 being mapped to 1.

 ### Hints
 - Hint #1: Stringification holds the key to solve this problem simply. Your parameters should both be Any, and you can use the String(describing:) initializer to stringify them.
 - Hint #2: You need to loop over all the characters in both stringified character arrays. To avoid out of bounds problems, make sure you start by checking both strings are the same length.
 - Hint #3: You should store your character mappings using a dictionary of type [Character: Character].
 - Hint #4: If you convert the characters of each string into an array you’ll find subscripting significantly easier.
 - Hint #5: When you loop over each letter in the current string, you can check if it exists as a key in your character map. For characters that exist, check that its value matches the letter in the second string – if it doesn’t, it’s not an isomorphic string.
 - Hint #6: If your letter doesn’t exist as a key in the character map, it’s possible the second string’s letter does exist as a value attached to a different key. If so, it’s not an isomorphic string.
 - Hint #7: If the character isn’t already a key, and the second string’s letter isn’t already a value, then add the character and matching second string letter to your character mapping dictionary.
 - Hint #8: If you’ve made it through all the characters in the first string and not encountered any problems, you have an isomorphic string.
 */

func challenge57(first firstValue: Any, second secondValue: Any) -> Bool {
    let first = String(describing: firstValue)
    let second = String(describing: secondValue)
    guard first.count == second.count else { return false }
    var characterMap = [Character: Character]()
    let firstArray = Array(first)
    let secondArray = Array(second)
    for (index, character) in firstArray.enumerated() {
        let otherCharacter = secondArray[index]
        if let currentMapping = characterMap[character] {
            if currentMapping != otherCharacter {
                return false
            }
        } else {
            if characterMap.values.contains(otherCharacter) {
                return false
            }
            characterMap[character] = otherCharacter
        }
    }
    return true
}

print("Challenge 57 Isomorphic values: ", challenge57(first: "clap", second: "slap"))

/*:
 ## Challenge 58: Balanced brackets
 Difficulty: Easy
 
 Write a function that accepts a string containing the characters (, [, {, <, >, }, ], and ) in any arrangement and frequency. It should return true if the brackets are opened and closed in the correct order, and if all brackets are closed. Any other input should false.
 ### Sample input and output
 - The string “()” should return true.
 - The string “([])” should return true.
 - The string “([])(<{}>)” should return true.
 - The string “([]{}<[{}]>)” should return true.
 - The string “” should return true.
 - The string “}{” should return false.
 - The string “([)]” should return false.
 - The string “([)” should return false.
 - The string “([” should return false.
 - The string “[<<<{}>>]” should return false.
 - The string “hello” should return false.

 ### Hints
 - Hint #1: You should start by making the most simple check: does the string have only the eight different characters that are allowed?
 - Hint #2: Each type of opening bracket has only one matching opening bracket, so you should store that data somehow – a dictionary would seem sensible.
 - Hint #3: Every bracket need to be closed at some point, but not necessarily immediately – it might be closed many characters later, for example. So, you need to push it onto a stack, then wait.
 - Hint #4: As you loop over each character in the string, it’s either an opening bracket or a closing bracket. If it’s an opening one it can go on your stack; if it’s a closing one, then it should be the matching pair of whatever is on the end of your bracket stack.
 - Hint #5: If the function ends with anything left in the bracket stack it means there was one bracket that was not closed – a failure.
 */

func challenge58(input: String) -> Bool {
    /*
     first, though: ensuring that only brackets appear in the string.
     This can be done by creating a CharacterSet from the list of good letters (([{<>}])),
     then inverting the set and ensuring the input string doesn’t match
     */
    let validBrackets = "([{<>}])"
    let validCharacterSet = CharacterSet(charactersIn: validBrackets).inverted
    guard input.rangeOfCharacter(from: validCharacterSet) == nil else { return false }
    let matchingBrackets: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">"]
    var usedBrackets = [Character]()
    for bracket in input {
        if matchingBrackets.keys.contains(bracket) {
            // this is an opening bracket
            usedBrackets.append(bracket)
        } else {
            // this is a closing bracket – try to pull off our previous open
            if let previousBracket = usedBrackets.popLast() {
                if matchingBrackets[previousBracket] != bracket {
                    // if they don't match, this is a bad string
                    return false
                }
            } else {
                // we don't have an opening bracket, this is a bad string
                return false
            }
        }
    }
    return usedBrackets.count == 0
}

print("Challenge 58 Balanced brackets: \(challenge58(input: "{}(()})"))")

/*:
 ## Challenge 59: Quicksort
 Difficulty: Tricky
 
 Create an extension for arrays that sorts them using the quicksort algorithm.
 - Tip #1: The quicksort algorithm picks an item from its array to use as the pivot point, then splits itself into either two parts (less than or greater than) or three (less, greater, or equal). These parts then repeat the pivot and split until the entire array has been split, then it gets rejoined so that less, equal, and greater are in order.
 - Tip #2: I can write quicksort from memory, but I cannot write fully optimized quicksort from memory. It’s a complex beast to wrangle, and it requires careful thinking – honestly, I have better things to keep stored in what little space I have up there! So, don’t feel bad if your attempt is far from ideal: there’s no point creating a perfect solution if you struggle to remember it during an interview.
 - Tip #3: Quicksort is an algorithm so well known and widely used that you don’t even write a space in its name – it’s “quicksort” rather than “quick sort”.
 ### Sample input and output
 - The array [12, 5, 4, 9, 3, 2, 1] should become [1, 2, 3, 4, 5, 9, 12].
 - The array ["f", "a", "b"] should become ["a", "b", "f"].
 - The array [String]() should become [].
 
 ### Hints
 - Hint #1: You will need to extend Array with a constraint on their elements so that they must be Comparable – that’s what lets us sort items.
 - Hint #2: There are lots of ways to pick a pivot point; choosing a random item is probably best.
 - Hint #3: You can do most of the work with filter() if you want.
 - Hint #4: For maximum performance, try to solve the challenge in-place using inout.
 */

extension Array where Element: Comparable {
    //slow version of quicksort
    func challenge59a() -> [Element] {
        guard count > 1 else { return self }
        // pivot on the center of the array
        let pivot = self[count / 2]
        // create three new buckets that we'll sort ourselves into
        var before = [Element]()
        var after = [Element]()
        var equal = [Element]()
        // loop over all items, placing each one into a bucket by comparing against our pivot
        for item in self {
            if item < pivot {
                before.append(item)
            } else if item > pivot {
                after.append(item)
            } else {
                equal.append(item)
            }
        }
        // call this function recursively then return the combined input
        return before.challenge59a() + equal + after.challenge59a()
    }
    
    //even slower than challenge59a quicksort
    func challenge59b() -> [Element] {
        guard count > 1 else { return self }
        let pivot = self[count / 2]
        let before = filter { $0 < pivot }
        let after = filter { $0 > pivot }
        let equal = filter { $0 == pivot }
        return before.challenge59b() + equal + after.challenge59b()
    }
    
/*:
The truth is that picking a pivot point is complicated, and in fact the way you choose a pivot really depends on your array. For example, **if your array is often already sorted, using count / 2 is a great choice**. If your array is very large, then you’ll want to take a more complex approach because the time spent picking a better pivot is going to pay off with reduced sort time. So, you might choose something like median of three, where you pick three random elements from the array and pivot on whichever one lies in the center.
 
**The reason for choosing a random pivot point is that quicksort’s performance varies depending on its data**. If you had the array [1, 2, 500, 2, 1] and you pivoted on the center, 500, you’ll do a lot of work for almost no gain. **Choosing a random pivot point every time means that you minimize the chance of consistently choosing a bad pivot point**, which helps quicksort perform well overall.
 
Once you’ve chosen a good pivot point, from the extensive research that’s been done into quicksort, the walk you through what is probably the most optimized form of quicksort I can write from memory. It’s not the fastest out there, but it’s still about 25x faster than the solutions above while still being more or less readable – and still passing this challenge.
 
 ##### Let me walk you through how it works:
 1. The function works entirely in place, so it’s a `mutating` method.
 2. It’s called using left and right parameters, which marks the array start and end position that’s being sorted. This will initially be 0 and the array length - 1.
 3. It picks a pivot at the end of the array, and also creates a variable that marks the point in the array that will store where items are greater than the pivot.
 4. It then loops through the array, counting from `left` to `right`. Again, initially that’s 0 and the array length - 1.
 5. If the current item being scanned is less than the pivot, it swaps them item with whatever is at the split point, then moves the split point up one place.
 6. Move the right parameter (that’s the one being used as our pivot) to the split point.
 7. Finally, call itself twice more, passing in the left-hand side first, then the right-hand side second.
 */
    //25x faster quick sort without comment for memorization
    mutating func challenge59c(left: Int, right: Int) { //initially, left = 0 and right = array length - 1
        guard left < right else { return }
        let pivot = self[right]
        var splitPoint = left
        for i in left ..< right {
            if self[i] < pivot {
                (self[i], self[splitPoint]) = (self[splitPoint], self[i])
                splitPoint += 1
            }
        }
        (self[right], self[splitPoint]) = (self[splitPoint], self[right])
        challenge59c(left: left, right: splitPoint - 1)
        challenge59c(left: splitPoint + 1, right: right)
    }
    
    //25x faster quick sort with comments
    mutating func challenge59cc(left: Int, right: Int) { //initially, left = 0 and right = array length - 1
        // make sure we have a sensible range to work with
        guard left < right else { return }
        // use the right-hand element, because that's moved last
        let pivot = self[right]
        // set our split point – the marker where elements start being greater than the pivot – to be the left edge
        var splitPoint = left
        // count through all items in the array
        for i in left ..< right {
            // if this item is less than our pivot
            if self[i] < pivot {
                // move it so that it's at the split point
                (self[i], self[splitPoint]) = (self[splitPoint], self[i])
                // then move the split point forward one place
                splitPoint += 1
            }
        }
        // move our pivot item to the split point
        (self[right], self[splitPoint]) = (self[splitPoint], self[right])
        // recursively call this function on everything before the split…
        challenge59cc(left: left, right: splitPoint - 1)
        // …and everything after the split
        challenge59cc(left: splitPoint + 1, right: right)
    }
}

let arr = [1,3,4,5,3,2,1,6,8,1,2]
print("Challenge 59a Quick sort: \(arr.challenge59a())")
var arr2 = [1,3,4,5,3,2,1,6,8,1,2]
arr2.challenge59cc(left: 0, right: arr2.count - 1)
print("Challenge 59cc Recursive Quick sort: \(arr2)")

/*
 ## Challenge 60: Tic-Tac-Toe winner
 Difficulty: Tricky
 
 Create a function that detects whether either player has won in a game of Tic-Tac-Toe.
 
 **Tip**: A tic-tac-toe board is 3x3, containing single letters that are either X, O, or empty. A win is three Xs or Os in a straight line.
 ### Sample input and output
 - The array `[["X", "", "O"], ["", "X", "O"], ["", "", "X"]]` should return true.
 • The array `[["X", "", "O"], ["X", "", "O"], ["X", "", ""]]` should return true.
 • The array `[["", "X", ""], ["O", "X", ""], ["O", "X", ""]]` should return true.
 • The array `[["", "X", ""], ["O", "X", ""], ["O", "", "X"]]` should return false.
 • The array `[["", "", ""], ["", "", ""], ["", "", ""]]` should return false.
 ### Hints
 - Hint #1: Your board parameter should be [[String]] – an array of array of strings.
 = Hint #2: You can evaluate the rows and columns in a loop.
 - Hint #3: You can evaluate diagonals using two checks: one from top left to bottom right, and one from bottom left to top right.
 - Hint #4: You might want to use a nested function to make your code cleaner.
 */

func challenge60a(_ board: [[String]]) -> Bool {
    for i in 0 ..< 3 {
        // check each row
        if board[i][0] != "" && board[i][0] == board[i][1] && board[i][0] == board[i][2] {
            return true
        }
        // now check diagonally top left to bottom right
        if board[0][0] != "" && board[0][0] == board[1][1] && board[0][0] == board[2][2] {
            return true
        }
        // and check diagonally bottom left to top right
        if board[0][2] != "" && board[0][2] == board[1][1] && board[0][2] == board[2][0] {
            return true
        }
        // if we're still here there's no winner
        // check each column
        if board[0][i] != "" && board[0][i] == board[1][i] && board[0][i] == board[2][i] {
            return true
        }
    }
    return false
}

func challenge60b(_ board: [[String]]) -> Bool {
    //clean this up, and in doing so make the code much more readable, we can create a nested isWin() function that returns true if all three squares contain a move from the same player
    func isWin(_ first: String, _ second: String, _ third: String) -> Bool {
        guard first != "" else { return false }
        return first == second && first == third
    }
    for i in 0 ..< 3 {
        if isWin(board[i][0], board[i][1], board[i][2]) {
            return true
        }
        if isWin(board[0][i], board[1][i], board[2][i]) {
            return true
        }
    }
    if isWin(board[0][0], board[1][1], board[2][2]) {
        return true
    }
    if isWin(board[0][2], board[1][1], board[2][0]) {
        return true
    }
    return false
}

func challenge60c(_ board: [[String]]) -> Bool {
    func isWin(_ first: String, _ second: String, _ third: String) -> Bool {
        guard first != "" else { return false }
        return first == second && first == third
    }
    for i in 0 ..< 3 {
        if isWin(board[i][0], board[i][1], board[i][2]) {
            return true
        }
        if isWin(board[0][i], board[1][i], board[2][i]) {
            return true
        }
    }
    // if either the first one or the second check is a winning move then they will return true, otherwise false
    return isWin(board[0][0], board[1][1], board[2][2]) || isWin(board[0][2], board[1][1], board[2][0])
}

/*:
 ## Challenge 61: Find prime numbers
 Difficulty: Tricky
 
 Write a function that returns an array of prime numbers from 2 up to but excluding N, taking care to be as efficient as possible.
 
 **Tip**: Calculating primes is easy. Calculating primes efficiently is not. Take care!
 
 ### Sample input and output
 - The code `challenge61(upTo: 10)` should return 2, 3, 5, 7.
 - The code `challenge61(upTo: 11)` should return 2, 3, 5, 7; remember to exclude the upper bound.
 - The code challenge61(upTo: 12) should return 2, 3, 5, 7, 11.
 ### Hints
 - Hint #1: Writing code to find whether one number is prime or not is very different to writing code to find all prime numbers – there’s a reason this is in the algorithms chapter.
 - Hint #2: When given a number, you decide whether it’s prime by checking whether it has any factors. When given a range of numbers, you want to take the opposite approach: assume all numbers are prime, then remove numbers that are composites by multiplying primes.
 - Hint #3: This is known as the Sieve of Eratosthenes: take the number 2, then mark all multiples of 2 as being not prime. Then take the number 3 and repeat. Then 5 (no need to check 4; that’s a multiple of 2), then 7 (no need to check 6; that’s a multiple of 3), and so on. What remains must be prime.
 - Hint #4: Once you have an array containing which numbers are prime and which are not, you just need to extract the numbers that are prime and return them.

 #### Sieve of Erastosthenes
 - an algorithm that is over 2000 years old
 - Here it is: mark your entire range of numbers as being prime, so let’s say that’s 0 to 10. We know that 0 and 1 can’t be prime by definition, so we mark those as not prime. Now we loop from 2 up to the maximum of our range: if that number is currently marked prime, then we can mark all its multiples as not prime. So, 2 is prime, which means 4, 6, and 8 are not, so we mark them as not prime. We then continue to the next number, which is 3, and mark its multiples as not prime: 6 and 9. We then continue to 4, but it’s already been marked as not prime so we can continue to 5, and so on.
 */

func challenge61(upTo max: Int) -> [Int] {
    guard max > 1 else { return [] }
    var sieve = [Bool](repeating: true, count: max) //create an array of True up to the max
    sieve[0] = false
    sieve[1] = false
    for number in 2 ..< max {
        if sieve[number] == true {
            for multiple in stride(from: number * number, to: sieve.count, by: number) {
                /*
                 stride(from:to:by:)
                    - Returns a sequence from a starting value to, but not including, an end value, stepping by the specified amount.
                    - by parameter = The amount to step by with each iteration. A positive stride iterates upward; a negative stride iterates downward.
                    - Return value = A sequence from start toward, but not including, end. Each value in the sequence steps by stride.
                */
                sieve[multiple] = false
            }
        }
    }
    return sieve.enumerated().compactMap { $1 == true ? $0 : nil } //if value is true
}

print("Challenge 61 Find Primes: \(challenge61(upTo: 100))")

/*:
 ## Challenge 62: Points to angles
 Difficulty: Tricky
 
 Write a function that accepts an array of CGPoint pairs, and returns an array of the angles between each point pair. Return the angles in degrees, where 0 or 360 is straight up.
 
 Tip: If it helps your thought process, imagine each point pair as being two touches on the screen: you have the first touch and the second, what is the angle between them?
 
 ### Sample input and output
 Here is some code you can test with:
 ```
 var points = [(first: CGPoint, second: CGPoint)]()
 points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: -100)))
 points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: -100)))
 points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 0)))
 points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 100)))
 points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: 100)))
 points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 100)))
 points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 0)))
 points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: -100)))
 print(challenge62(points: points))
 ```
 If your code has worked correctly, that should print [0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0]. Returning 360.0 for the first number is also acceptable.
 ### Hints
 - Hint #1: You’re mapping an array of one type to an array of another type. Yes, that means map() is a good idea.
 - Hint #2: You’ll need to use `atan2()` to calculate the angle between any two points, providing the Y delta and the X delta as its two parameters.
 - Hint #3: `atan2()` works in radians, so you’ll need to convert the value to degrees using the formula `degrees = radians * 180 / Double.pi`.
 - Hint #4: Where “0” lies is of course arbitrary, but the convention is that 0 degrees runs along the positive X axis. You need to correct for this.
 */

import UIKit

func challenge62(points: [(first: CGPoint, second: CGPoint)]) -> [CGFloat] {
    //this is common when working with UIPanGestureRecognizer
    return points.map {
        let radians = atan2($0.first.y - $0.second.y, $0.first.x - $0.second.x)
        var degrees = (radians * 180 / CGFloat.pi) - 90
        if (degrees < 0) { degrees += 360.0 }
        if degrees == 360 { degrees = 0 }
        return degrees
    }
}

var points = [(first: CGPoint, second: CGPoint)]()
points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: -100)))
points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: -100)))
points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 0)))
points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 100)))
points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: 100)))
points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 100)))
points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 0)))
points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: -100)))
print("Challenge 62: Points to Angles = ", challenge62(points: points))

/*:
 ## Challenge 63: Flood fill
 Difficulty: Taxing
 
 Write a function that accepts a two-dimensional array of integers that are 0 or 1, a new number to place, and a position to start. You should read the existing number at the start position, change it to the new number, then change any surrounding numbers that matched the start number, then change any surrounding those, and so on - like a flood fill algorithm in Photoshop.
 
 **Tip** #1: If you value your sanity, you will add import GameplayKit then generate your grid using this code:
 ```
 let random = GKMersenneTwisterRandomSource(seed: 1)
 var grid = (1...10).map { _ in (1...10).map { _ in
    Int(random.nextInt(upperBound: 2))
 }}
 ```
 That will allow you to produce the same grid every time, which ought to make debugging easier. (Note: I made grid a variable rather than a constant for a reason.)
 
 **Tip** #2: A flood fill works by filling grid positions directly above, below, to the left, and to the right, stopping only when a different number is encountered.
 
 **Tip** #3: If the arrays contained all zeros, filling 5 would cause the arrays to contain all 5s because all numbers would be filled.
 
 ### Sample input and output
 Given the following set up:
 ```
 let random = GKMersenneTwisterRandomSource(seed: 1)
 let grid = (1...10).map { _ in (1...10).map { _ in Int(random.nextInt(upperBound: 2)) } }
 ```
 
 You will have the following grid:
 
 ```
 [0, 0, 0, 0, 0, 1, 0, 0, 1, 1]
 [0, 1, 1, 0, 0, 0, 0, 1, 0, 0]
 [0, 1, 0, 0, 0, 0, 0, 0, 1, 1]
 [1, 0, 1, 0, 0, 1, 1, 0, 0, 0]
 [1, 0, 1, 0, 1, 1, 1, 1, 1, 0]
 [1, 0, 1, 1, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 1, 1, 1, 0, 1, 1]
 [1, 1, 1, 0, 0, 1, 1, 1, 1, 1]
 [1, 1, 0, 1, 1, 1, 1, 0, 0, 0]
 [0, 1, 1, 0, 0, 1, 0, 1, 1, 1]

 ```
 
 After running this code:
 
 `challenge63(fill: 5, in: grid, at: (x: 2, y: 0))`
 
 You will have the following grid:
 ```
 [5, 5, X, 5, 5, 1, 5, 5, 1, 1]
 [5, 1, 1, 5, 5, 5, 5, 1, 0, 0]
 [5, 1, 5, 5, 5, 5, 5, 5, 1, 1]
 [1, 0, 1, 5, 5, 1, 1, 5, 5, 5]
 [1, 0, 1, 5, 1, 1, 1, 1, 1, 5]
 [1, 0, 1, 1, 5, 5, 5, 5, 5, 5]
 [0, 0, 0, 0, 1, 1, 1, 5, 1, 1]
 [1, 1, 1, 0, 0, 1, 1, 1, 1, 1]
 [1, 1, 0, 1, 1, 1, 1, 0, 0, 0]
 [0, 1, 1, 0, 0, 1, 0, 1, 1, 1]
 ```
 
 Note, in the above grid I marked with X where the fill started, but that will be a five too.
 ### Hints
 - Hint #1: You can solve this using a recursive function, or using a loop.
 - Hint #2: You will almost certainly find it useful to add print() statements inside your loop or function that displays what square is being manipulated, and perhaps also the current grid.
 - Hint #3: Keep a stack of squares that need to be filled. Start by adding your initial square, then loop over that and remove one square to fill / spread from each time.
 */
import GameplayKit //needed for GKMersenneTwisterRandomSource
let random = GKMersenneTwisterRandomSource(seed: 1)
var grid = (1...10).map { _ in (1...10).map { _ in Int(random.nextInt(upperBound: 2)) } }

func challenge63a(fill: Int, in grid: [[Int]], at point: (x: Int, y: Int)) -> [[Int]] {
    var returnValue = grid
    var squaresToFill = [point]
    let startNumber = grid[point.y][point.x]
    func tryAddMove(_ move: (x: Int, y: Int)) {
        guard move.x >= 0 else { return }
        guard move.x < 10 else { return }
        guard move.y >= 0 else { return  }
        guard move.y < 10 else  { return }
        guard returnValue[move.y][move.x] == startNumber else { return }
        squaresToFill.append(move)
    }
    while let square = squaresToFill.popLast() {
        guard returnValue[square.y][square.x] != fill else { continue }
        returnValue[square.y][square.x] = fill
        tryAddMove((x: square.x, y: square.y - 1))
        tryAddMove((x: square.x, y: square.y + 1))
        tryAddMove((x: square.x - 1, y: square.y))
        tryAddMove((x: square.x + 1, y: square.y))
    }
    return returnValue
}

//recursive solution
func challenge63b(fill newNumber: Int, in grid: inout [[Int]], at point: (x: Int, y: Int), replacing: Int? = nil) {
    // bail out if this position is invalid
    guard point.x >= 0 else { return }
    guard point.x < 10 else { return }
    guard point.y >= 0 else { return  }
    guard point.y < 10 else { return }
    // `replacing` will be set on 2nd and subsequent runs
    let startNumber = replacing ?? grid[point.y][point.x]
    if grid[point.y][point.x] == startNumber {
        // adjust this point
        grid[point.y][point.x] = newNumber
        // and fill in surrounding squares
        challenge63b(fill: newNumber, in: &grid, at: (x: point.x, y: point.y - 1), replacing: startNumber)
        challenge63b(fill: newNumber, in: &grid, at: (x: point.x, y: point.y + 1), replacing: startNumber)
        challenge63b(fill: newNumber, in: &grid, at: (x: point.x - 1, y: point.y), replacing: startNumber)
        challenge63b(fill: newNumber, in: &grid, at: (x: point.x + 1, y: point.y), replacing: startNumber)
    }
}
challenge63b(fill: 5, in: &grid, at: (x: 2, y: 0))
print("Challenge 63b: Flood fills = \(grid)")

/*:
 ## Challenge 64: N Queens
 Difficulty: Taxing
 
 There are M different ways you can place N queens on an NxN chessboard so that none of them are able to capture others. Write a function that calculates them all and prints them to the screen as a visual board layout, and returns the number of solutions it found.
 
 **Tip**: A queen moves in straight lines vertically, horizontally, or diagonally. You need to place all eight queens so that no two share the same row, column, or diagonal.
 
 **Tip**: In the more advanced version of this challenge you would be required to return only the fundamental solutions, which means unique positions excluding rotations and reflections. This is not a requirement here.
 
 ### Sample input and output
 - In an 8x8 board you need to place 8 queens. There are 92 possible arrangements, so your function should print each of them then return 92.
 - In a 10x10 board you need to place 10 queens. There are 724 possible arrangements, so your function should print each of them then return 724.
 ### Here is a suggested example layout for solutions:
 ``` Here is a suggested example layout for solutions
 .......Q
 ...Q....
 Q.......
 ..Q.....
 .....Q..
 .Q......
 ......Q.
 ....Q...
 ```
 ### Hints
 - Hint #1: Your queen placement function ought to call itself. The first time it’s called it represents the first queen being placed, the second it’s the second queen, and so on. If you reach N then you’ve placed all the queens and you have a solution.
 - Hint #2: In order to be sure you’ve found all solutions, you need to exhaust all possible placements.
 - Hint #3: Sometimes you will have placed six queens and realized there’s nowhere valid for the seventh to go. Be prepared to backtrack.
 - Hint #4: Two queens occupy the same column if their X difference is equal to their Y difference, or their X difference is equal to their negative Y difference.
 - Hint #5: You can solve this problem using a one-dimensional array of integers
 */
func challenge64(board: [Int], queen queenNumber: Int) -> Int {
    if queenNumber == board.count {
        // we hit a solution – print it out
//        print("Solution:", board)
        for row in 0 ..< board.count {
            for col in 0 ..< board.count {
                if board[row] == col {
                    print("Q", terminator: "")
                } else {
                    print(".", terminator: "")
                }          }
            print("")
        }
        print("")
        return 1
    } else {
        // keep track how many solutions were found by our recursive calls
        var count = 0
        // loop over every column
        boardLoop: for column in 0 ..< board.count {
            // check only queens that are placed already
            for row in 0 ..< queenNumber {
                // find where this queen was placed
                let otherQueenColumn = board[row]
                // if this queen is placed in the column we are checking, stop checking other queens and go to the next column
                if otherQueenColumn == column { continue boardLoop }
                // calculate the difference in our row/column and the checking queen's row/column
                let deltaRow = queenNumber - row
                let deltaCol = otherQueenColumn - column
                // if we are on a diagonal with this queen, stop checking other queens and proceed to the next column
                if deltaRow == deltaCol { continue boardLoop }
                if deltaRow == -deltaCol { continue boardLoop }
            }
            // if we're still here it means this move is valid, so take a copy of the board and make the move on the copy
            var boardCopy = board
            boardCopy[queenNumber] = column
            // now call ourselves recursively, placing one queen number higher, and adding it return value to our solution counter
            count += challenge64(board: boardCopy, queen: queenNumber + 1)
        }
        // return our solution counter to the caller
        return count
    }
}
// create an initial board full of zeros
let emptyBoard = [Int](repeating: 0, count: 8)
// call the solution function with the first queen and an empty board
let solutionCount = challenge64(board: emptyBoard, queen: 0)
print("Found \(solutionCount) solutions")

/*:
 ### Note
 If you don’t mind using inout for your board rather than making changes on a copy, you can make the algorithm perform more than 2x faster with no other changes. In my opinion, **using inout for speed is only a good idea if you’re working with performance-critical code** – the principle of least astonishment applies to code too, and making copies of your data structure is easier to understand.

 */

//: [Next](@next)
