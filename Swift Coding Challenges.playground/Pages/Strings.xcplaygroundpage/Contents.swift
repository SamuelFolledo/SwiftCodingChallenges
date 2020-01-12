//: ## String Coding Challenges
import PlaygroundSupport
import UIKit

//: ### Challenge 1: Are the letters unique?
//: Write a function that accepts a String and returns true if the string has only unique letters, taking letter case into account
func challenge1(input: String) -> Bool {
    return Set(input).count == input.count
}
assert(challenge1(input: "No duplicates") == true, "Challenge 1 failed")

//: ### Challenge 2: Is a string a palindrome?
//: Write a function that accepts a String and returns true if the string reads the same when reversed, ignoring case
func challenge2(input: String) -> Bool {
    let lowercase = input.lowercased()
    return lowercase.reversed() == Array(lowercase)
}

//:### Challenge 3: Do two strings contain the same characters?
//: Write a function that accepts two String parameters, and returns true if they contain the same characters in any order taking into account letter case.
func challenge3(string1: String, string2: String) -> Bool {
    return Array(string1).sorted() == Array(string2).sorted()
}

//: ### Challenge 4: Does one string contain another?
//: Write your own version of the contains() method on String that ignores letter case, and without using the existing contains() method
extension String {
    func fuzzyContains(_ string: String) -> Bool {
        return range(of: string, options: .caseInsensitive) != nil
    }
}
print("Hello world".fuzzyContains("WORLD")) //should return true

//: ### Challenge 5: Count the characters
//: Write a function that accepts a string, and returns how many times a specific character appear
func challenge5a(input: String, char: Character) -> Int {
    var letterCount = 0
    for letter in input {
        if letter == char {
            letterCount += 1
        }
    }
    return letterCount
}
func challenge5b(input: String, char: Character) -> Int {
    return input.reduce(0) { //starting with 0, go over every character in the string. If a given letter matches the input character, then it will add 1 to the reduce counter, otherwise it will return the current reduce counter
        $1 == char ? $0 + 1 : $0
    }
}
func challenge5d(input: String, char: String) -> Int {
    let modified = input.replacingOccurrences(of: char, with: "") //calculate the number of times a letter appears in a string by removing it, then comparing the lengths of the original and modified strings
    return input.count - modified.count
}
