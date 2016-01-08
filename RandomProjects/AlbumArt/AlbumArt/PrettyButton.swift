//
//  PrettyButton.swift
//  AlbumArt
//
//  Created by Jo Albright on 10/15/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class PrettyButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func drawRect(rect: CGRect) {

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    
    }

}
