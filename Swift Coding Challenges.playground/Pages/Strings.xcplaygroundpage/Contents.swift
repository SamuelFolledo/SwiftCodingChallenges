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
    let result = string.filter {
        used.updateValue(true, forKey: $0) == nil
    }
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

//: Personal Challenge: Find longest suffix
public extension StringProtocol {
///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        guard !isEmpty && !aString.isEmpty else { return "" }
        var idx = endIndex
        var strIdx = aString.endIndex
        repeat {
            formIndex(before: &idx)
            aString.formIndex(before: &strIdx)
            guard String(self[idx]).compare(String(aString[strIdx]), options: options) == .orderedSame else {
                formIndex(after: &idx)
                break
            }
        } while idx > startIndex && strIdx > aString.startIndex
        return String(self[idx...])
    }
}

//: ### Challenge 13: Run-length encoding
//: Write a function that accepts a string as input, then returns how often each letter is repeated in a single run, taking case into account.
func challenge13a(input: String) -> String {
    var currentLetter: Character?
    var returnValue = ""
    var letterCounter = 0
    for letter in input {
        if letter == currentLetter {
            letterCounter += 1
        } else {
            if let current = currentLetter {
                returnValue.append("\(current)\(letterCounter)")
            }
            currentLetter = letter
            letterCounter = 1
        }
    }
    if let current = currentLetter {
          returnValue.append("\(current)\(letterCounter)")
    }
    return returnValue
}

func challenge13b(input: String) -> String {
    var returnValue = ""
    var letterCounter = 0
    let letterArray = Array(input)
    for i in 0 ..< letterArray.count {
        letterCounter += 1
        if i + 1 == letterArray.count || letterArray[i] != letterArray[i + 1] {
            returnValue += "\(letterArray[i])\(letterCounter)"
            letterCounter = 0
        }
    }
    return returnValue
}

//: ### Challenge 14:
//:
/*
## Challenge 14: String permutations
Write a function that prints all possible permutations of a given input string.
Hints
Hint #1: Your function will need to call itself.
Hint #2: The number of lines printed should be the factorial of the length of your string, e.g. “wombat” has six characters, so will have 6! permutations: 6 x 5 x 4 x 3 x 2 x 1, or 720.
Hint #3: You’ll find it easiest to convert the string to a character array for easier indexing.
Hint #4: Each time your function is called, it should loop through all letters in the string so that all combinations are generated.
Hint #5: You can slice arrays using strArray[0...3].
Hint #6: You can convert string array slices into strings just by using an initializer: String(strArray[0...3]).
*/
func challenge14(string: String, current: String = "") {
    let length = string.count
    let strArray = Array(string)
    if (length == 0) {       // there's nothing left to re-arrange; print the result
        print("******")
        print("If", current)
        print("******")
    } else {
//        print("Else", current)
        // loop through every character
        for i in 0 ..< length {
            // get the letters before me
            let left = String(strArray[0 ..< i])
            // get the letters after me
            let right = String(strArray[i+1 ..< length])
            print("L=\(left)\tR=\(right)\t\tCurr=\(current)\tS=\(String(strArray[i]))")
            // put those two together and carry on
            challenge14(string: left + right, current: current + String(strArray[i]))
        }
    }
}

challenge14(string: "123")

//: ### Challenge 15:
//:
//Challenge 15: Reverse the words in a string
//Difficulty: Taxing
//Write a function that returns a string with each of its words reversed but in the original order, without using a loop.
//Sample input and output
//• The string “Swift Coding Challenges” should return “tfiwS gnidoC segnellahC”.
//• The string “The quick brown fox” should return “ehT kciuq nworb xof”.
/*Hints
 Hint #1: You should start by converting the string into an array by separating on spaces.
 Hint #2: You can reverse the characters in a string by calling reversed() on it.
 Hint #3: You can create a string from a character array.
 Hint #4: You want to convert an array of left to right strings into an array of right to left strings, all without using a loop - this is a perfect use for map().
 Hint #5: Once you have an array of reversed strings, you can create a single string using joined().
*/
func challenge15(input: String) -> String {
    let words = input.components(separatedBy: " ") //separate string by white space to create an array of word
    let reversed = words.map { String($0.reversed()) } //reverse each word using a higher order function map
    return reversed.joined(separator: " ") //combine each word separated by white space
}

//: ### Challenge 16:
//:

//: ### Challenge 17:
//:

//: ### Challenge 18:
//:

//: ### Challenge 19:
//:
