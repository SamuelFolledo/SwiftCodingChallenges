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
                    print("Before \(returnValue)")
                    // swap them
                    returnValue.swapAt(index, index + 1)
                    // and mark that we made a swap so the loop will repeat
                    swapsMade = true
                    print("After \(returnValue)")
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

//: [Next](@next)
