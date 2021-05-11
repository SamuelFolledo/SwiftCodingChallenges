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

print("Challenge 57: ", challenge57(first: "clap", second: "slap"))

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



//: [Next](@next)
