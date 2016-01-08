//
//  GoonieTableViewCell.swift
//  GitHubGoonies
//
//  Created by Jo Albright on 9/28/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class GoonieTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
