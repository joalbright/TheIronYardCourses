//
//  TrackTableViewCell.swift
//  AlbumArt
//
//  Created by Jo Albright on 5/29/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

protocol TrackTableViewCellDelegate {
    
    func playSongWithURL(url: String)
    
}

class TrackTableViewCell: UITableViewCell {
    
    var delegate: TrackTableViewCellDelegate?
    
    var trackInfo: [String:AnyObject]! {
        
        didSet {
            
            trackNameLabel.text = trackInfo["trackName"] as? String
            
        }
        
    }

    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBAction func toggleSong(sender: UIButton) {
        
        if let url = trackInfo["previewUrl"] as? String {
            
            delegate?.playSongWithURL(url)
            
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
