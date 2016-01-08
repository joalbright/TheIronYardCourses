// Playground - noun: a place where people can play

import UIKit

class Box: NSObject {
    
    var sides = 6
    
}

class Truck: NSObject {
    
    var contents: [Box]?
    var wheels: [Wheel] = []
    
}

class Wheel: NSObject {
    
    var type: Rubber?
}

class Rubber: NSObject {
    
    var color = UIColor.darkGrayColor()
    
}

var truck: Truck?

truck = Truck()

truck?.wheels = [Wheel()]
truck?.contents = [Box()]

truck?.contents?[0].sides
truck?.wheels[0].type


////////////////////////////////
////////////////////////////////

  ///// //    ///// ///// // //
  //    //    // // //    // //
  //    //    // // ///// // //
  //    //    // //    // // //
  ///// ///// ///// ///// /////

////////////////////////////////
////////////////////////////////


class Request: NSObject {
    
    func makeRequestWithCompletion(number1: Int, number2: Int, delay: Int, completion: ((num1: Int, num2: Int) -> Void)?) {
        
        
        // dispatch async -> global
        // run a http request
        
        // dispatch async -> main
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Int(NSEC_PER_SEC) * delay)), dispatch_get_main_queue()) { () -> Void in
            
            if let c = completion {
                
                c(num1: number1 * 10,num2: number2 * 100)

            }

        }
        
        
    }
    
    func doNormalStuff() {
        
//        makeRequestWithCompletion { (<#Int#>, <#Int#>) -> Void in
//            <#code#>
//        }
        
        makeRequestWithCompletion(2, number2: 5, delay: 1) { (num1, num2) -> Void in
            
            println("num1 \(num1) and num2 \(num2)")
            
        }
        
        makeRequestWithCompletion(45, number2: 13, delay: 0) { (num1, num2) -> Void in
            
            println("num1 \(num1) and num2 \(num2)")
            
        }
        
        makeRequestWithCompletion(10, number2: 10, delay: 0, completion: nil)
        
    }
    
}

Request().doNormalStuff()








