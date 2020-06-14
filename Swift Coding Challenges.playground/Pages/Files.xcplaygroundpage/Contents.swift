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
    guard let path = Bundle.main.path(forResource: filename, ofType: nil) else { return } //get the path of the file
    guard let input = try? String(contentsOfFile: path, encoding: .utf8) else { return } //get the contents of the file as multiline
    var lines = input.components(separatedBy: "\n") //create an array of lines
    guard lines.count > 0 else { return }
    lines.reverse() //reverse the lines array
    for i in 0 ..< min(lines.count, lineCount) { //loop until either it reach whichever is smaller between lines.count and lineCount passed
        print(lines[i])
    }
}

/*:
 ## Challenge 28: Log a message
 Difficulty: Easy
 
 Write a logging function that accepts accepts a path to a log file on disk as well as a new log message. Your function should open the log file (or create it if it does not already exist), then append the new message to the log along with the current time and date.
 
 ### Tip:
 
 It’s important that you add line breaks along with each message, otherwise the log will just become jumbled.
 
 ### Sample input and output
 
 - If the file does not exist, running your function should create it and save the new message
 
 - If it does exist, running your function should load the existing content and append the message to the end, along with suitable line breaking.
 
 ### Hints
 - Hint #1: I think it would be reasonable to use contentsOfFile to load the existing log file into a string.
 - Hint #2: You can use try? and nil coalescing to provide a default value if the existing log file doesn’t exist.
 - Hint #3: How you format the date and time for each message will be interesting, but don’t forget KISS: Keep It Simple, Stupid.
 - Hint #4: What should happen if you can’t write the log file? This wasn’t specified in the challenge description, so you get to use some initiative.
 */


//: [Next](@next)
