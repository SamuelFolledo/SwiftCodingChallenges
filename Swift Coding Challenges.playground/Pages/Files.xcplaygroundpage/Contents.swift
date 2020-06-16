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
// 1. How you load the log file, or provide a default value if the log hasn’t been created yet
// 2. How you format dates to include in each log message.
// 3. How you write the updated log file back to disk, handling any errors that might occur.
func challenge28(log message: String, to logFile: String) {
    var existingLog = (try? String(contentsOfFile: logFile)) ?? "" //existingLog will either be an empty string or the contents read from the log file.
    existingLog.append("\(Date()): \(message)\n") //“Year-Month-Day Hour:Minute:Second
    do { // writing data to disk is a throwing function, so you need to decide what to do with any errors
        try existingLog.write(toFile: logFile, atomically: true, encoding: .utf8)
    } catch let error {
        print("Failed to write to log: \(error.localizedDescription)")
    }
}

/*:
## Challenge 29: Documents directory
 
Difficulty: Easy
Write a function that returns a URL to the user’s documents directory.
 
### Sample input and output
- Your function should need no input, and return a URL pointing to /Users/
yourUserName/Documents on macOS, and /path/to/container/Documents on iOS.
 
### Hints
 
- Hint #1: This is one you either know or you don’t. I’d be tempted to answer “that’s something I could find on Google” if the answer fled from my brain in an interview.
 
- Hint #2: You should investigate the urls(for:in) method of FileManager.
 
- Hint #3: The user has only one documents directory.
*/
func challenge29() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//: [Next](@next)
