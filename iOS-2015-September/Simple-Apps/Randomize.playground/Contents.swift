//: Playground - noun: a place where people can play

import UIKit

func randomize<T: SignedNumberType>(min: T, _ max: T) -> T? {
    
    func drand() -> Double { return Double(arc4random_uniform(101)) / 100 }
    
    if let _min = min as? Int, let _max = max as? Int { return (Int(drand() * Double(_max - _min)) + _min) as? T }
    if let _min = min as? Double, let _max = max as? Double { return (drand() * Double(_max - _min) + _min) as? T }
    if let _min = min as? Float, let _max = max as? Float { return (Float(drand() * Double(_max - _min)) + _min) as? T }
    if let _min = min as? CGFloat, let _max = max as? CGFloat { return (CGFloat(drand() * Double(_max - _min)) + _min) as? T }
    
    return nil
    
}

randomize(5, 10)
randomize(3.2, 5.4)

let xMin: CGFloat = 13.4
let xMax: CGFloat = 54.3

randomize(xMin, xMax)
