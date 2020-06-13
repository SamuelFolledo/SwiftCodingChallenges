//: [Previous](@previous)
/*: ## Challenge 27: Print last lines
Difficulty: Easy
 
Write a function that accepts a filename on disk, then prints its last  N lines in reverse order, all on a single line separated by commas.
 ### Hints
 - Hint #1: Use the ```contentsOfFile``` initializer to pull in the text, then ```components(separatedBy:)``` to create an array of lines.
 - Hint #2: Arrays have a built-in ```reverse()``` method that flip them around in-place.
 - Hint #3: You need to print the last  N lines, but of course you don’t want to read beyond the size of the array. Make sure you use the ```min()``` function to choose the lesser of the two.
*/
import UIKit

func challenge27(filename: String, lineCount: Int) {
    guard let path = Bundle.main.path(forResource: filename, ofType: nil) else { return }
    guard let input = try? String(contentsOfFile: path, encoding: .utf8) else { return }
    var lines = input.components(separatedBy: "\n")
    guard lines.count > 0 else { return }
    lines.reverse()
    for i in 0 ..< min(lines.count, lineCount) {
        print(lines[i])
    }
}


//: [Next](@next)
