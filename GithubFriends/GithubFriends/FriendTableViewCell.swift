//
//  FriendTableViewCell.swift
//  GithubFriends
//
//  Created by Jo Albright on 5/13/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    var friendIndex: Int!
    var friendInfo: [String:AnyObject?]! {
        
        didSet {
            
            reposButton.tag = friendIndex
            gistsButton.tag = friendIndex
            
            friendNameLabel.text = friendInfo["name"] as? String
            
            let repoCount = friendInfo["public_repos"] as! Int
            reposButton.setTitle("Repos \(repoCount)", forState: .Normal)
            
            let gistCount = friendInfo["public_gists"] as! Int
            gistsButton.setTitle("Gists \(gistCount)", forState: .Normal)
            
            let avatarURL = friendInfo["avatar_url"] as! String
            
            let url = NSURL(string: avatarURL)!
            
            let data = NSData(contentsOfURL: url)!
            
            let image = UIImage(data: data)
            
            avatarImageView.image = image
            
            avatarImageView.layer.cornerRadius = 24
            avatarImageView.layer.masksToBounds = true
            
        }
        
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var reposButton: UIButton!
    @IBOutlet weak var gistsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
