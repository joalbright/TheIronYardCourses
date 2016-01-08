//
//  RepoTableViewCell.swift
//  GithubFriends
//
//  Created by Jo Albright on 5/13/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    var repoInfo: [String:AnyObject]! {
        
        didSet {
            
            languageColor = colors[]
            
        }
        
    }
    
    @IBOutlet weak var languageColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
