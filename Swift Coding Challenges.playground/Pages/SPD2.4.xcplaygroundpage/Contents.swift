//: [Previous](@previous)

import Foundation

/*:
 # Twitter Follow Suggestions
 ## Q1 Twitter Follow Suggestions
 Code out 2 solutions for the following question. Use your pseudocode to guide your comments.

 ## Twitter Follow Suggestions
 You’re working an internship at Twitter and are tasked to improve suggestions for accounts to follow, which already works great for established accounts because it uses content from your tweets and other accounts you follow to suggest new ones. However, when a new user signs up none of this information exists yet, but Twitter still wants to make some follow suggestions. Your team asked you to implement a function that accepts a new user’s handle and an array of many other users’ handles, which could be very long – Twitter has over 330 million active accounts! You need to calculate a similarity score between a pair of handles by looking at the letters each contains, scoring +1 for each letter in the alphabet that occurs in both handles but scoring –1 for each letter that occurs in only one handle. Your function should return k handles from the array that have the highest similarity score to the new user’s handle.

 Example execution:

 ```
 handles = ['DogeCoin', 'YangGang2020', 'HodlForLife', 'fakeDonaldDrumpf', 'GodIsLove', 'BernieOrBust']
 ```
 `suggest('iLoveDogs', handles, k=2)` should return `['GodIsLove', 'DogeCoin']`
 ### Tips:
 1. Use the simplifications that were brainstormed in class.
 2. Create a plan for how you’ll solve the problem from the absolute simplest possible version as step 1, then remove one of the simplifications in step 2, then another in step 3, and finally remove all simplifications so you are solving the full version of the problem in your final step. DO NOT attempt to solve the full version of the problem right away. The goal of this is to break the problem down into smaller, simpler steps to create an incremental path from the simplest version to the full problem. Practicing this will help you during real interviews, especially when you hear a new problem and think to yourself “OMG this is hard!” – This is to develop a strategy for how to move past those thoughts.
 */

func suggest(searchWord: String, count: Int) -> [String] {
    var scoreWords: [String: Int] = [:]
    let words = ["DogeCoin", "YangGang2020", "HodlForLife", "fakeDonaldDrumpf", "GodIsLove", "BernieOrBust"]
    var possibleSearchWords: [String] = []
    for i in 0..<searchWord.count { //loop through each letter from beginning
        for j in i..<searchWord.count { //loop through each letter from i to end of the word
//            print("I:\(i)\tJ:\(j)\t=\t\(Array(searchWord)[i])-\(Array(searchWord)[j])")
            let possibleSearchWord = String(Array(searchWord)[i...j])
//            print(possibleSearchWord)
            possibleSearchWords.append(possibleSearchWord)
        }
    }
    for word in words {
        for possibleWord in possibleSearchWords {
            if word.contains(possibleWord) { //check if possibleWord is in word
                if scoreWords[word] == nil {
                    //if word doesn't exist in the dictionary
                    scoreWords[word] = possibleWord.count
                } else if scoreWords[word]! < possibleWord.count {
                    //if score is lesser than possibleWord's count
                    scoreWords[word] = possibleWord.count
                }
            }
        }
    }
    print(scoreWords)
    //sort scoreWords
    let sortedResults = (Array(scoreWords).sorted { $0.1 > $1.1 })
    var results: [String] = []
    //get the top scores to return
    for result in sortedResults {
        results.append(result.key)
        if results.count == count {
            break
        }
    }
    return results
}
print(suggest(searchWord: "iLoveDogs", count: 2))

/*:
 ## Problem 2
 Given an array a of n numbers and a target value t, find two numbers whose sum is t.
 
 Example: a=[5, 3, 6, 8, 2, 4, 7], t=10 ⇒ [3, 7] or [6, 4] or [8, 2]
 */

func find_pair(numbers: [Int], target: Int) -> (Int?, Int?) {
    for number in numbers {
        for num in numbers where num + number == target {
            return (number, num)
        }
    }
    return (nil, nil)
}
let numbers = [1,2,3,4,5,6]
print(find_pair(numbers: numbers, target: 8))


/*:
 ## Problem 3
 Given an array a of n numbers and a count k find the k largest values in the array a.

 Example: a=[5, 1, 3, 6, 8, 2, 4, 7], k=3 ⇒ [6, 8, 7]
 */
let numbersToSort = [5, 1, 3, 6, 8, 2, 4, 7]
func getMaxNumbers(numbers: [Int], maxCount: Int) -> [Int] {
    return Array(numbers.sorted{ $0 > $1 }.prefix(maxCount))
}
print(getMaxNumbers(numbers: numbersToSort, maxCount: 3))

/*:
 ## Problem 3
 Given two arrays a and b of numbers and a target value t, find a number from each array whose sum is closest to t.
 
 Example: a=[9, 13, 1, 8, 12, 4, 0, 5], b=[3, 17, 4, 14, 6], t=20 ⇒ [13, 6] or [4, 17] or [5, 14]
 */

func getClosestSum(numbers1: [Int], numbers2: [Int], target: Int) -> [Int] {
    var result: [Int] = []
    for num1 in numbers1 {
        for num2 in numbers2 {
            if !result.isEmpty { //if result is not empty
                //use absolute to turn the difference to positive
                let currentDiff = abs(num1 + num2 - target)
                if currentDiff == 0 {
                    result[0] = num1
                    result[1] = num2
                    return result
                }
                //use absolute to turn the max difference to positive
                let maxDiff = abs(result[0] + result[1] - target) //turn to positive
                if currentDiff < maxDiff {
                    //if currentDiff is less than maxDiff, update result
                    result[0] = num1
                    result[1] = num2
                }
            } else {
                //if result is empty, append num1 and num2
                result.append(contentsOf: [num1, num2])
            }
        }
    }
    return result
}

let numbers1 = [9, 13, 1, 8, 12, 4, 0, 5]
let numbers2 = [3, 17, 4, 14, 6]
print(getClosestSum(numbers1: numbers1, numbers2: numbers2, target: 2))
//: [Next](@next)
