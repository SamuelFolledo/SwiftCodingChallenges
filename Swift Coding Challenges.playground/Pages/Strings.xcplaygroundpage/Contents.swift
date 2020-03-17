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

func challenge7a(input: String) -> String { //perfect solution
    var seenSpace = false
    var returnValue = ""
    for letter in input {
        if letter == " " {
            if seenSpace { continue } //if we see a space again then continue, meaning do not append it to returnValue
            seenSpace = true
        } else {
            seenSpace = false
        }
        returnValue.append(letter)
    }
    return returnValue
}

func challenge7b(input: String) -> String { //50% slower because of regex, but almost unnoticeable
    return input.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil) //"[space]+" means "match one or more spaces" so that will cause all multiple spaces to be replaced with a single space
}

//: ### Challenge 8: String is rotated
//: Write a function that accepts two strings, and returns true if one string is rotation of the other, taking letter case into account.
//: Tip: A string rotation is when you take a string, remove some letters from its end, then append them to the front. For example, “swift” rotated by two characters would be “ftswi”.
func challenge8(input: String, rotated: String) -> Bool {
    guard input.count == rotated.count else { return false }
    let combined = input + input
    return combined.contains(rotated)
}

//: ### Challenge 9: Find pangrams
//: Write a function that returns true if it is given a string that is an English pangram, ignoring letter case.
//: Tip - A pangram is a string that contains every letter of the alphabet at least once.
func challenge9(input: String) -> Bool {
    let set = Set(input.lowercased())
    let letters = set.filter { $0 >= "a" && $0 <= "z" }
    return letters.count == 26
}

//: ### Challenge 10: Vowels and consonants
//: Given a string in English, return a tuple containing the number of vowels and consonants.
func challenge10a(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let consonants = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() {
        let stringLetter = String(letter)
        if stringLetter.rangeOfCharacter(from: vowels) != nil {
            vowelCount += 1
        } else if stringLetter.rangeOfCharacter(from: consonants) != nil {
            consonantCount += 1
        }
    }
    return (vowelCount, consonantCount)
}

func challenge10b(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = "aeiou"
    let consonants = "bcdfghjklmnpqrstvwxyz"
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() {
        let stringLetter = String(letter)
        if vowels.contains(stringLetter) {
            vowelCount += 1
        } else if consonants.contains(stringLetter) {
            consonantCount += 1
        }
    }
    return (vowelCount, consonantCount)
}

func challenge10c(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = "aeiou"
    let consonants = "bcdfghjklmnpqrstvwxyz"
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() {
        if vowels.contains(letter) {
            vowelCount += 1
        } else if consonants.contains(letter) {
            consonantCount += 1
        }
    }
    return (vowelCount, consonantCount)
}


//: ### Challenge 11: Three different letters
//: Write a function that accepts two strings, and returns true if they are identical in length but have no more than three different letters, taking case and string order into account.
func challenge11(first: String, second: String) -> Bool {
    guard first.count == second.count else { return false }
    let firstArray = Array(first)
    let secondArray = Array(second)
    var differences = 0
    for (index, letter) in firstArray.enumerated() {
        if secondArray[index] != letter {
            differences += 1
            if differences == 4 {
                return false
            }
        }
    }
    return true
}


//: ### Challenge 12: Find longest prefix
//: Write a function that accepts a string of words with a similar prefix, separated by spaces, and returns the longest substring that prefixes all words.
func challenge12(input: String) -> String {
    let parts = input.components(separatedBy: " ")
    guard let first = parts.first else { return "" }
    var currentPrefix = ""
    var bestPrefix = ""
    for letter in first {
        currentPrefix.append(letter)
        for word in parts {
            if !word.hasPrefix(currentPrefix) {
                return bestPrefix
            }
        }
        bestPrefix = currentPrefix
    }
    return bestPrefix
}

//: ### Challenge 13:
//:

//: ### Challenge 14:
//:

//: ### Challenge 15:
//:

//: ### Challenge 16:
//:

//: ### Challenge 17:
//:

//: ### Challenge 18:
//:

//: ### Challenge 19:
//:
