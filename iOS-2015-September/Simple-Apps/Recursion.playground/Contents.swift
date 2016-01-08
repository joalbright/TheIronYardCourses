//: Playground - noun: a place where people can play

import UIKit

//func infiniteLoop() {
//    
//    print("infinite")
//    infiniteLoop()
//    
//}
//
//infiniteLoop()


let info = [

    "name" : "Jo",
    "interests" : [
    
        "hobby" : "photography",
        "work" : "computers"
    
    ]

]

func search(info: [String:AnyObject], forString string: String) -> Bool {
    
    for (_,value) in info {
        
        if value is String {
            
            if value as! String == string { return true }
            
        }
        
    }
    
    for (_,value) in info {
        
        if value is [String:AnyObject] {
            
            print("hi")
            if search(value as! [String:AnyObject], forString: string) { return true }
            
        }
        
    }
    
    return false
    
}

search(info, forString: "jo")



