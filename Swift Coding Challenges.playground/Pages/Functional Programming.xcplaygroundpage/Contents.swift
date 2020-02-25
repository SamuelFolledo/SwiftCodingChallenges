//: [Previous](@previous)

import Foundation

let numbers = [1,5,3,4,9]
let numbersSquared = numbers.map({$0 * $0})
print("Nums Squared = ",numbersSquared)

let numbersSum = numbers.reduce(0) {
    $0 + $1
}
print("Nums Sum = ", numbersSum)

let numbersProduct = numbers.reduce(1,*)
print("Nums Product = ", numbersProduct)


func sumOfTwos(total: Int, numbers:[Int]) {
//    var result: (Int, Int) = (0,0)
//    for (i, num) in numbers.enumerated() {
    var numb = 0
    let result = 0
//    for i in 0..<numbers.count {
    for (i, num) in numbers.enumerated() {
        if numb != num {
            numb = num
            continue
        }
        if numbers[i] - numb == total {
            print("\(num) + \(numb) = \(total)")

        }
        
//        let dif = total - numbers[i]
//        print("\(i) = \(dif)")
        
    }
    print("\(numb) + \(result) = \(total)")
}

sumOfTwos(total: 7, numbers: numbers)






//: [Next](@next)
