// Playground - noun: a place where people can play

import UIKit
import CoreGraphics

// NSMutableArray * names = [NSMutableArray arrayWithObjects:@"Jim",@"Sue",@"Ted",nil];
var names: [String] = ["Jim","Sue","Ted"]

// [names addObjects:[NSArray arrayWithObjects:@"Tom",@"Sam",nil]];
names += ["Tom","Sam"]

var str = "Hi" + ","

str += " my name is Jo"

var info: [String:AnyObject] = ["name":"Jo","age":31,"books":[["title":"Monster"]]]

var num: Int = 0
var num1 = 0.0

var total: CGFloat = CGFloat(num + Int(num1))

var rect = CGRectMake(total, total, total, total)




// NSArray * shapes = @[@"Circle",@"Square",@"Triangle"];
var shapes = ["Circle","Square","Triangle"]

// for (NSString * shape in shapes) {
//   NSLog(@"%@",shape);
// }
for shape in shapes {
    
//    println("shape " + shape)
    
}


for i in 0...5 {
    
//    println(i)
    
}

for i in 0..<shapes.count {
    
//    println(shapes[i])
    
}

for (i,shape) in enumerate(shapes) {
    
    var shapeInfo = "\(i) \(shape) in \(shapes)"
    
//    println(shapeInfo)
    
}


var myInfo = ["name":"Jo","age":"31","brand":"Nike"]


for (key,value) in myInfo {
    
    // if ([key isEqualTo:@"age"]) {
//    if key == "age" {
//        
//        println("my age is \(value)")
//        
//    }
    
    switch key {
        
    case "age" :
        
        println("my age is \(value)")
        
    case "name" :
        
        println("my name is \(value)")
        
    default :
        
        println("my \(key) is \(value)")
        
    }
    
}


var number: Int = 0
var isTrue: Bool = true









