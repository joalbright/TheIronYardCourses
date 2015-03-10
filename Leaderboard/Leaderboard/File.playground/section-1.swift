// Playground - noun: a place where people can play

import Foundation

enum AgeGroupType {
    
    case Baby
    case Toddler
    case Child
    case Teen
    case Adult
    
    func name() -> String {
        
        switch self {
            
        case .Baby : return "Baby"
        case .Toddler : return "Toddler"
        case .Child : return "Child"
        case .Teen : return "Teen"
        case .Adult : return "Adult"
            
        }
        
    }
    
}

func name(type: AgeGroupType) -> String {
    
    switch type {
        
    case .Baby : return "Baby"
    case .Toddler : return "Toddler"
    case .Child : return "Child"
    case .Teen : return "Teen"
    case .Adult : return "Adult"
        
    }
    
}


func getAgeGroup(user: User) -> AgeGroupType {
    
    switch user.age {
        
    case 0,1 : return .Baby
    case 2...4 : return .Toddler
    case 5...12 : return .Child
    case 13...19 : return .Teen
    default : return .Adult
        
    }
    
}

class User {
    
    var age: Int = 0
    // - ()
    func getAgeGroup() -> AgeGroupType {
        
        switch age {
            
        case 0,1 : return .Baby
        case 2...4 : return .Toddler
        case 5...12 : return .Child
        case 13...19 : return .Teen
        default : return .Adult
            
        }
        
    }
    
}

class Car {
    
    var age: Int = 0
    // + ()
    
    init() {
        
        println("hello")
        
    }
    
    class func carWithColor() -> Car {
        
        return Car()
        
    }
    
    class func seatsInModel(model:String) -> Int {
        
        return 4
        
    }
    
}

Car.seatsInModel("4 Door")

//Car()

var mack = User()
mack.age = 21
mack.getAgeGroup().name()
name(mack.getAgeGroup())

name(getAgeGroup(mack))

func weeksOld(year: Int) -> Int { return year * 52 }

func monthsOld(year: Int) -> Int { return year * 12 }


func addNumbers(number1: Int, number2: Int) -> Int { return number1 + number2 }


weeksOld(mack.age)
monthsOld(mack.age)


var mustang = Car()
mustang.age = 10

weeksOld(mustang.age)






