//: Playground - noun: a place where people can play

import UIKit

enum ShapeType : Int {
    
    case Triangle = 3
    case Rectangle = 4
    case Pentagon = 5
    case Hexagon = 6
    case Septagon = 7
    case Octogon = 8
    
}

class Shape {
    
    var sides: Int!
    
    var fillColor: UIColor?
    var strokeColor: UIColor?
    
    init(type: ShapeType) {

        sides = type.rawValue
        
    }
    
}

var square1 = Shape(type: .Rectangle)

var squarepixels = 4 * square1.sides

var triangle1 = Shape(type: .Triangle)

var trianglepixels = 4 * triangle1.sides

// homework help
class BodyPart { }

class Mouth: BodyPart {
    
    var lipsColor: UIColor!
    var teethCount: Int!
    
    var badBreath: Bool = false
    var fullOfFood: Bool = false
    
    init(teeth: Int, lips: UIColor) {
        
        teethCount = teeth
        lipsColor = lips
        
    }
    
    func chewFood(food: AnyObject) {

        // chew 3 times then swallow
        
    }
    
    func yawn() { }
    
}

class Face: BodyPart {
    
    var mouth: Mouth = Mouth(teeth: 0, lips: UIColor.greenColor())
    
}









