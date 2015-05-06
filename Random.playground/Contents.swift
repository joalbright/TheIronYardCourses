//: Playground - noun: a place where people can play

import UIKit


// simple changeable variable of type String
var str = "Hello, playground"

var myFirstName = "Jo"

// a grouping of options
enum AgeGroups : Int {
    
    case Baby = 0
    case Child = 3
    case Teenager = 13
    case Adult = 20
    
}

// a variable with type AgeGroup
var myAgeGroup = AgeGroups.Adult

// a variable with type AgeGroup
var yourAgeGroup = AgeGroups.Teenager

println(myAgeGroup.hashValue)
println(myAgeGroup.rawValue)

println(yourAgeGroup.hashValue)
println(yourAgeGroup.rawValue)

// exhuastive switch
switch myAgeGroup {
    
case .Adult : println("I am an adult")
case .Baby : println("I am a baby")
case .Child : println("I am a child")
case .Teenager : println("I am a teenager with a rebel side")
    
}

// simple Array containing type String
var peeps = ["Jo","Tim","Brit"]

// get item at index 0
peeps[0]

// do not try to access an item outside of the Array
//peeps[3]

// iterating through each item in peeps
for peep in peeps {
    
    println(peep)
    
    // do not remove items from an Array within the loop on the Array
//    peeps.removeAtIndex(0)
    
}

// iterating through 0 to one less than peeps item count
for index in 0..<peeps.count {
    
    println(index)
    println(peeps[index])
    
}

// iterating through 0 to 5
for i in 0...5 {
    
}



// a dictionary is a collection of key : value pairs
var myProfile = [

    "name" : "Jo",
    "age" : "31",
    "gender" : "male",

]

// get the value for key "name"
myProfile["name"]


for (key,value) in myProfile {
    
    println("\(key) = \(value)")
    
}


var points = [

    "Shannon" : "4000000",
    "Parker" : "2000000",
    "Kyle" : "2100000",
    "Chris" : "100000000000000000000000000",
    "Aimee" : "3000000000"

]

for (name,total) in points {
    
    println("\(name) has \(total)")
    
}

//points.keys.array


// graphs are cool
for num in 0...100 {
    
    num % 10
    
}

















