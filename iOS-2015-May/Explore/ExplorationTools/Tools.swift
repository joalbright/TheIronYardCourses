//
//  Tools.swift
//  Explore
//
//  Created by Jo Albright on 7/8/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

private let _allTools = Tools()

public class Tools: NSObject {
   
    public class func allTools() -> Tools { return _allTools }
    
    var name = "Jo"
    
    public func getName() -> String {
        
        return name
        
    }
    
}
