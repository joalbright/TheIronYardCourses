//
//  SelfieTableViewCell.swift
//  Selfie
//
//  Created by Jo Albright on 10/30/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import Parse

class SelfieTableViewCell: UITableViewCell {

    var selfie: PFObject? {
        
        didSet {
            
            updateInfo()
            
        }
        
    }
    
    @IBOutlet weak var selfieImageView: UIImageView!

    func updateInfo() -> Void {
        
        NSLog("%@",selfie!)
        let userImageFile = selfie?["image"] as? PFFile
        
        
        userImageFile?.getDataInBackgroundWithBlock { (imageData, error) in
            
            if error == nil {
                
                self.selfieImageView.image = UIImage(data: imageData!)
                
            }
            
        }
        
    }

}










