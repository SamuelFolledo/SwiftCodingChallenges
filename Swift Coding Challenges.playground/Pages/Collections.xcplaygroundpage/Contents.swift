//: [Previous](@previous)

import Foundation

extension Collection {
    func challenge37a(count: Character) -> Int {
        var total = 0
        // loop over every element
        for item in self {
            // stringify this integer
            let str = String(item)
            // loop over letter in the string
            for letter in str {
                if letter == count {
                    total += 1
                }
            }
        }
        return total
    }
//    func challenge37b(count: Character) -> Int {
//        return self.reduce(0) {
//            $0 + String($1).filter { (char: Character) -> Bool in
//                char == count
//            }.count
//        }
//    }
}

[5, 15, 55, 515].challenge37a(count: "5")
