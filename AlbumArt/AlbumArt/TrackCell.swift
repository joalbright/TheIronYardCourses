//
//  TrackCell.swift
//  AlbumArt
//
//  Created by Jo Albright on 10/13/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import SVGPlayButton

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var playButton: SVGPlayButton!
    
    @IBAction func pressedPlayButton(sender: SVGPlayButton) {
        
        print("pressed")
        
    }
    
    override func awakeFromNib() {
        
        // runs after loaded from storyboard
        print(playButton)
        
        playButton.progressTrackColor = UIColor.lightGrayColor()
        playButton.progressColor = UIColor.orangeColor()
        playButton.playColor = UIColor.orangeColor()
        playButton.pauseColor = UIColor.orangeColor()
        
        playButton.willPlay = { self.willPlayHandler() }
        playButton.willPause = { self.willPauseHandler() }

    }
    
    private func willPlayHandler() {
        print("willPlay")
    }
    
    private func willPauseHandler() {
        print("willPause")
    }
    

}
