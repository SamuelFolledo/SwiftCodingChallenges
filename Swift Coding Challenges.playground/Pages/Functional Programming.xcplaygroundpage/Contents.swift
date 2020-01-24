//: [Previous](@previous)

import Foundation

let numbers = [1,2,3,4]
let numbersSquared = numbers.map({$0 * $0})
print("Nums Squared = ",numbersSquared)

let numbersSum = numbers.reduce(0) {
    $0 + $1
}
print("Nums Sum = ", numbersSum)

let numbersProduct = numbers.reduce(1,*)
print("Nums Product = ", numbersProduct)







//: [Next](@next)
