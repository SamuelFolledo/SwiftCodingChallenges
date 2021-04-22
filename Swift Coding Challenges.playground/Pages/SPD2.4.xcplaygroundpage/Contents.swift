//: [Previous](@previous)

import Foundation

/*:
 # Twitter Follow Suggestions
 ## Q1 Twitter Follow Suggestions
 Code out 2 solutions for the following question. Use your pseudocode to guide your comments.

 ## Twitter Follow Suggestions
 You’re working an internship at Twitter and are tasked to improve suggestions for accounts to follow, which already works great for established accounts because it uses content from your tweets and other accounts you follow to suggest new ones. However, when a new user signs up none of this information exists yet, but Twitter still wants to make some follow suggestions. Your team asked you to implement a function that accepts a new user’s handle and an array of many other users’ handles, which could be very long – Twitter has over 330 million active accounts! You need to calculate a similarity score between a pair of handles by looking at the letters each contains, scoring +1 for each letter in the alphabet that occurs in both handles but scoring –1 for each letter that occurs in only one handle. Your function should return k handles from the array that have the highest similarity score to the new user’s handle.

 Example execution:

 ```
 handles = ['DogeCoin', 'YangGang2020', 'HodlForLife', 'fakeDonaldDrumpf', 'GodIsLove', 'BernieOrBust']
 ```
 `suggest('iLoveDogs', handles, k=2)` should return `['GodIsLove', 'DogeCoin']`
 ### Tips:
 1. Use the simplifications that were brainstormed in class.
 2. Create a plan for how you’ll solve the problem from the absolute simplest possible version as step 1, then remove one of the simplifications in step 2, then another in step 3, and finally remove all simplifications so you are solving the full version of the problem in your final step. DO NOT attempt to solve the full version of the problem right away. The goal of this is to break the problem down into smaller, simpler steps to create an incremental path from the simplest version to the full problem. Practicing this will help you during real interviews, especially when you hear a new problem and think to yourself “OMG this is hard!” – This is to develop a strategy for how to move past those thoughts.
 */

//: [Next](@next)
