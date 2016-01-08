//: Playground - noun: a place where people can play

import UIKit

///////////////
/////////////// Struct
///////////////

var name = "Jo"

unsafeAddressOf(name)

var name2 = name

unsafeAddressOf(name2)

name2.appendContentsOf("e")

name

///////////////
/////////////// Class
///////////////

var name3: NSMutableString = "Jo"

unsafeAddressOf(name3)

var name4 = name3

unsafeAddressOf(name4)


name4.appendString("ey")
name3

name3 = "Tim"
name4

unsafeAddressOf(name3)





