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

/*:
 ## Challenge 30: New JPEGs
 
 Difficulty: Easy
 
 Write a function that accepts a path to a directory and returns an array of all JPEGs that have been created in the last 48 hours.
 
 **Tip #1**: For the purpose of this task, just looking for “.jpg” and “.jpeg” file extensions is sufficient.
 
 **Tip #2**: For this challenge, assume time is regular and constant, i.e. the user has not changed their timezone or moved into or out from daylight savings.
 
 **Tip #3**: Use the terminal command touch -t YYYYMMDDHHMM somefile.jpg to adjust the creation time of a file, e.g. touch -t 201612250101.
 
 ### Sample input and output
 
 - If your directory contains three JPEGs older than 48 hours and three newer, your function should return the names of the three newer.
 
 ### Hints
 
 - Hint #1: Use the ```contentsOfDirectory()``` method of ```FileManager``` to pull out the list of files in your target directory.
 
 - Hint #2: You can compare two dates directly using ```>```.
 
 - Hint #3: You can read the attributes of a file using the ```attributesOfItem()``` method on ```FileManager```, and you’ll want to read the ```FileAttributeKey.creationDate``` from that dictionary.
 
 #### There are three parts to solving this challenge:
 
 1. Getting all files in the target directory, using the ```contentsOfDirectory()``` method on ```FileManager```.
 
 2. Filtering by JPEGs. The challenge statement makes it clear that just filtering on the path extension of JPEG and JPG is sufficient, so you can just check the ```pathExtension``` property of each file.
 
 3. Filtering by creation date, ensuring that only newer JPEGs are included.
 */
func challenge30(in directory: String) -> [String] {
    let fm = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    guard let files = try? fm.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else { return [] }
    var jpegs = [String]()
    for file in files {
        if file.pathExtension == "png" || file.pathExtension == "jpeg" {          guard let attributes = try? fm.attributesOfItem(atPath: file.path) else { continue }
            guard let creationDate = attributes[.creationDate] as? Date else { continue }
            if creationDate > Date(timeIntervalSinceNow: -60 * 60 * 48) {             jpegs.append(file.lastPathComponent)
            }
        }
    }
    return jpegs
}

/*:
 ## Challenge 31: Copy recursively
 
 Difficulty: Easy
 
 Write a function that accepts two paths: the first should point to a directory to copy, and the second should be where the directory should be copied to. Return true if the directory and all its contents were copied successfully; false if the copy failed, or the user specified something other than a directory.
 ### Sample input and output
 
 - If your directory exists and is readable, the destination is writeable, and the copy
 succeeded, your function should return true.
 
 - Under all other circumstances you should return false: if the directory does not exist or
 was not readable, if the destination was not writeable, if a file was specified rather than
 a directory, or if the copy failed for any other reason.
 
 ### Hints
 - Hint #1: FileManager has a dedicated copyItem() method that is perfectly capable of recursively copying directories.
 - Hint #2: To comply fully with the challenge, you must ensure the user does not specify a file to copy – this should accept only directories.
 - Hint #3: You should try the fileExists() method. It has a second parameter, specified as inout, that returns whether the requested item is a directory.
 -Hint #4: Never used ObjCBool before? Lucky you. Create your variable like this: var isDirectory: ObjCBool = false. Now call fileExists() then use its boolValue property to read the boolean value.

 */

func challenge31(source: String, destination: String) -> Bool {
    let fm = FileManager.default
    var isDirectory: ObjCBool = false
    guard fm.fileExists(atPath: source, isDirectory: &isDirectory) || isDirectory.boolValue == false else { return false }
    let sourceURL = URL(fileURLWithPath: source)
    let destinationURL = URL(fileURLWithPath: destination)
    do {
        try fm.copyItem(at: sourceURL, to: destinationURL)
    } catch {
        print("Copy failed: \(error.localizedDescription)")
        return false
    }
    return true
}



//: [Next](@next)
