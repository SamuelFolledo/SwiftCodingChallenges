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


//: ### Challenge 6: Remove duplicate letters from a string
//: Write a function that accepts a string as its input, and returns the same string just with duplicate letters removed.
func challenge6a(string: String) -> String {
    let arrayedString = string.map { String($0) } //turns string to array of strings
    let set = NSOrderedSet(array: arrayedString) //Ordered set, so it removes duplicated elements from arrayedString
    let lettersArray = Array(set) as! Array<String> //as! Array<String> is needed to put it back as a string
    return lettersArray.joined() //put them back to a string
}
print(challenge6a(string: "Kobeee"))

func challenge6b(string: String) -> String {
    var usedChars = [Character]()
    for letter in string {
        if !usedChars.contains(letter) { //if letter is in our usedArray, then append that character
            usedChars.append(letter)
        }
    }
    return String(usedChars)
}

func challenge6c(string: String) -> String {
    var used = [Character: Bool]()
    let result = string.filter {       used.updateValue(true, forKey: $0) == nil    }
    return String(result)
}

//: ### Challenge 7: Condense whitespace
//: Write a function that returns a strign with any consecutive spaces related with a single space
func challenge7(input: String) -> String { // That splits a string up by its spaces, then removes any empty items, and joins the remainder using a space, and is the ideal solution
    let components = input.components(separatedBy: .whitespacesAndNewlines)
    return components.filter { !$0.isEmpty }.joined(separator: " ")
}


