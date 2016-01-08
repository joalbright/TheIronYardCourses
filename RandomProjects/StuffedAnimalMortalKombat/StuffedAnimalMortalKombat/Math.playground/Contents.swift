//: Playground - noun: a place where people can play

import UIKit


let killCount: Int = 32
let killsPerLine: CGFloat = 10
let hw: CGFloat = 20
let padding: CGFloat = 5

for i in 0..<killCount {
    
    CGFloat(i) % killsPerLine
    
    floor(CGFloat(i) / killsPerLine)
    
    let x = (hw + padding) * (CGFloat(i) % killsPerLine)

}

