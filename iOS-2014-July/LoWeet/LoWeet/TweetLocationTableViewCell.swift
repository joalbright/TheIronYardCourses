//
//  TweetLocationTableViewCell.swift
//  LoWeet
//
//  Created by Jo Albright on 9/15/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

import UIKit

class TweetLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var tweetTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func editTweetLocation(sender: AnyObject) {
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
