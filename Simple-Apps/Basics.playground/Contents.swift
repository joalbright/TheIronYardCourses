//: Playground - noun: a place where people can play

import UIKit

enum OperationType: String {
    
    case Addition = "+"
    case Subtraction = "-"
    case Multiplication = "x"
    case Division = "/"
    case Modulo = "%"
    
}

func calculateNumbers(n1 n1: Double, n2: Double, operation: OperationType) -> Double {
    
    switch operation {
        
    case .Addition : return n1 + n2
    case .Subtraction : return n1 - n2
    case .Multiplication : return n1 * n2
    case .Division : return n1 / n2
    case .Modulo : return n1 % n2
        
    }
    
}

calculateNumbers(n1: 3, n2: 2, operation: .Modulo)





