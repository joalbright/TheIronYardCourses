//: Playground - noun: a place where people can play

import UIKit

class BodyPart {
    
    var isDamaged = false
    
}

class Arm : BodyPart {
    
    var hand: Hand!
    
    override init() {
        
        hand = Hand()
        
    }
    
}

class Hand : BodyPart {
    
    var fingers: [Finger] = []
    
    override init() {
        
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Thumb())
        
    }
    
    func closeHand() {
        
        for finger in fingers {
            
            finger.fingerCurl()
            
        }
        
    }
    
}

class Finger : BodyPart {
    
    var boneCount: Int!
    
    func fingerCurl() {
        
        println("Curling \(self)")
        
    }
    
}

class Thumb : Finger {
    
    var isDoubleJointed = false
    
}

var leftArm = Arm()

leftArm.hand.closeHand()














