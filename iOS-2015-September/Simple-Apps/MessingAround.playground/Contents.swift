import UIKit
import XCPlayground

var str = "Hello, playground"


let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

let box = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

box.backgroundColor = UIColor.redColor()

wrapperView.addSubview(box)

UIView.animateWithDuration(1, animations: { () -> Void in
    
    box.frame.origin.x = 200
    box.frame.origin.y = 200
    
}) { (_) -> Void in
    
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .CurveEaseOut, animations: { () -> Void in
        
        box.frame.origin.x = 20
        box.frame.origin.y = 100
        
    }, completion: { (_) -> Void in
        
        
        
    })
    
}

XCPlaygroundPage.currentPage.liveView = wrapperView


extension Array: CustomPlaygroundQuickLookable {
    
    public func customPlaygroundQuickLook() -> PlaygroundQuickLook {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
        
        for (i,_) in self.enumerate() {
            
            let box = UIView(frame: CGRect(x: i * 10 + 1, y: 2, width: 8, height: 8))
            
            box.backgroundColor = UIColor.whiteColor()
            
            view.addSubview(box)
            
        }
        
        return .View(view)
        
    }
    
}

let a = [0,1,2,3,4,5,6,8,9]



