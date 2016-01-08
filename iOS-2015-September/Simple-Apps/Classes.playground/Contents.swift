import UIKit

////////////////
//////////////// SHAPE Subclassing
////////////////

class Shape {
    
    var sides: Int?
    
}

class Rectangle: Shape {
    
    override init() {
        super.init()
        
        sides = 4
        
    }
    
}

class Triangle: Shape {
    
    override init() {
        super.init()
        
        sides = 3
        
    }
    
}

////////////////
//////////////// CAR Subclassing, Properties, Enum
////////////////


class Wheel {
    
    var size: Int = 20
    var rimColor: UIColor = UIColor.darkGrayColor()
    
}

class Seat {
    
    
}



class Engine {
    
    var size: String?
    
}

//var array1 = Array<Seat>()
//var array2: Array<Seat> = []
//var array3 = [Seat]()
//var array4: [Seat] = []

class Car {
    
    var engine: Engine?
    var steeringWheel: SteeringWheel?
    var seats: [Seat] = []
    var wheels: [Wheel] = []
    
    init() {
        
        wheels = [Wheel(),Wheel(),Wheel(),Wheel()]
        
        seats = [Seat(),Seat()]
        
    }
    
}

enum MaterialType {
    
    case Leather
    case Plastic
    
}

class SteeringWheel {
    
    var material: MaterialType?
    
}

var myCar = Car()

myCar.engine = Engine()
myCar.steeringWheel = SteeringWheel()

myCar.steeringWheel?.material = MaterialType.Leather
myCar.engine?.size = "v8"

myCar.wheels
myCar.seats

////////////////
//////////////// TOILET Classes
////////////////

class Toilet {
    
    var color: UIColor = UIColor.lightGrayColor()
    
    class func createOrangeToilet() -> Toilet {
    
        let toilet = Toilet()
        
        toilet.color = UIColor.orangeColor()
    
        return toilet
        
    }
    
    init() {
        
        // creates a default toilet
        
    }
    
    var clean: Bool = true
    
    func flushToilet() {
        
        self.clean = true
        
    }

    
    
    
}

////////////////
//////////////// BOX Class & Instance Objects
////////////////

class Box {
    
    var color: UIColor?
    var height: CGFloat = 0
    var width: CGFloat = 0
    
    func changeSize(size: CGSize) {
        
        height = size.height
        width = size.width
        
    }
    
}

var box1 = Box()
var box2 = Box()

box1.changeSize(CGSize(width: 10, height: 10))
box2.changeSize(CGSize(width: 20, height: 10))


////////////////
//////////////// Computer Thinking Flow
////////////////

var num1 = 1
var num2 = 2

func addNumbers() {
    
//    var num1 = 4
//    var num2 = 6
    
    num1 + num2
    
    num1 = 5
    num2 = 7
    
    num1 + num2
    
}

num1 + num2

addNumbers()

num1 + num2

//addNumbers(5, num2: 5)


////////////////
//////////////// Computer Thinking Flow
////////////////

class Math {
    
    var num1 = 0
    var num2 = 0
    
    func addNumbers() -> Int {
        
        return num1 + num2
        
    }
    
    func subtractNumbers() -> Int {
        
        return num1 - num2
        
    }
    
}

class Human {
    
    var math = Math()
    
    func setNumbers() {
        
        math.num1 = 5
        math.num2 = 7
        
        self.runMath()
        
    }
    
    func runMath() {
        
        self.doAddition()
        self.doSubtraction()
        
    }
    
    func doAddition() {
        
        let value = math.addNumbers()
        
    }
    
    func doSubtraction() {
        
        let value = math.subtractNumbers()
        
    }
    
}

let me = Human()

me.setNumbers()



let you = Human()

//you.setNumbers()

you.math.num1

me.math.num1


////////////////
//////////////// User Lab Work
////////////////

enum FavoriteColor : String {
    
    case Black
    case Magenta
    case Blue
    case Red
    case Yellow
    
}

class User {
    
    var name: String!
    var email: String!
    var password: String!
    var favoriteColor: FavoriteColor?
    
    func sayHelloTo(name: String) {
        
        print("\(self.name) says hi to \(name)")
        
    }
    
    func register(name: String, email: String, password: String) {
        
        self.name = name
        self.email = email
        self.password = password
        
    }
    
}

let jo = User()

jo.register("Jo", email: "me@jo2.co", password: "r4u523g4543ghrjkegrjh3k4rwesfe")

jo.sayHelloTo("Bob")










////////////////
//////////////// Optionals
////////////////


var color: String?

//color!

//color = "Red"

print(color == nil)

if color != nil { print(color!) }

//let n1 = 4.0
//let n2 = 5
//
//n1 + n2

print("The color is " + "Red")

print("The color is \(color)")

if let c = color {
    
    print("The color is " + c)
    
}













