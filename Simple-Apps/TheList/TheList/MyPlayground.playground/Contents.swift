//: Playground - noun: a place where people can play

import UIKit


protocol ChildDelegate {
    
    func iAmHungry()
    
}

class Parent : ChildDelegate {
    
    var children: [Child] = []
    
    func makeABaby() {
        
        let baby = Child()
        baby.delegate = self
        children.append(baby)
        
    }
    
    func iAmHungry() {
        
        // print child is hungry
        
    }
    
}

class Child {
    
    var delegate: ChildDelegate? // Parent
    
    func bellyRumbles() {
        
        delegate?.iAmHungry()
        
    }
    
}



