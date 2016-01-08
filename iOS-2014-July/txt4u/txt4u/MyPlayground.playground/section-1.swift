// Playground - noun: a place where people can play

import UIKit

// create a new array1
var array1 : [String] = []

// add Hi to array1
array1 += ["Hi"]

// create a new array2 based on array1
var array2 = array1

// add Hello to array2 (not array1)
array2 += ["Hello"]

array1

// create a new array3
var array3 = NSMutableArray()

// add Hi to array3
array3.addObject("Hi")

// point array4 to array3
var array4 = array3

// add Hello to array4 (which is the same as array3)
array4.addObject("Hello")

array3