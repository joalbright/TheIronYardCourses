// Playground - noun: a place where people can play

import UIKit

extension UIColor {
    
    class func peachColor() -> UIColor {
        
        return UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        
    }
    
}

UIColor.greenColor()
UIColor.peachColor()

private var kName = "nameKey"

extension UIView {
    
    var viewName: String {
        
        get {
            return objc_getAssociatedObject(self, &kName) as String
        }
        
        set {
            objc_setAssociatedObject(self, &kName, newValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    var area: CGFloat { return frame.size.height * frame.size.width }
    
}

var shape = UIView()

shape.viewName = "circle"

shape.viewName

var box = UIView(frame: CGRectMake(0, 0, 25, 40))

box.area

var box2 = UIView(frame: CGRectMake(0, 0, 100, 30))

box2.area

extension String {
    
    func broIt() -> String {
        
        return self + ", Bro!"
        
    }
    
    func howManyOfThisLetter(letter: String) -> Int {
        
        var letterCount = 0
        
        for c in self.startIndex..<self.endIndex {
            
            let range = Range<String.Index>(start: c, end: advance(c, 1))
            
            let character = self.substringWithRange(range)
            
            if character == letter {
                letterCount++
            }
            
        }
        
        return letterCount
        
    }
    
}


"Atlanta".howManyOfThisLetter("a")


"Sup".broIt()
"Want to get lunch".broIt()

var str = "Hello, playground"


var button = UIBarButtonItem()

button.customView?.subviews

