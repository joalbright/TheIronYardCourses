//
//  Constants.swift
//  CoreNotes
//
//  Created by Jo Albright on 6/23/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

let DEBUG = true

let categories: [String:(String,UIColor)] = [

    "Red" : ("Lava",UIColor(red:1, green:0.24, blue:0.11, alpha:1)),
    "Cyan" : ("Sky",UIColor.cyanColor()),
    "Yellow" : ("Lazy",UIColor.yellowColor()),
    "Purple" : ("Unicorn",UIColor.purpleColor()),
    "Orange" : ("Fruit",UIColor.orangeColor())

]

func categoryColor(name: String) -> UIColor {
    
    return categories[name]!.1
    
}

