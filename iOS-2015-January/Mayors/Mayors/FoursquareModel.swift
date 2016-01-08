//
//  FoursquareModel.swift
//  Mayors
//
//  Created by Jo Albright on 3/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

private let _fsModel = FoursquareModel()

class FoursquareModel: NSObject {
   
    var token: String?
    
    class func mainModel() -> FoursquareModel { return _fsModel }
    
}

class User: NSObject {
    
    var userInfo: [String:AnyObject]!
    var firstName: String!
    var lastName: String!
    
    init(resultInfo: [String:AnyObject]) {
        
        super.init()
        let responseInfo = resultInfo["response"] as [String:AnyObject]
        userInfo = responseInfo["user"] as [String:AnyObject]
        firstName = userInfo["firstName"] as String
        lastName = userInfo["lastName"] as String
        
    }
    
    func changeUserInfo(userInfo: [String:AnyObject]) {
        
        self.userInfo = userInfo
        
    }
    
}





