//
//  TrackCell.swift
//  AlbumArt
//
//  Created by Jo Albright on 10/13/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import SVGPlayButton
import AVFoundation

class TrackCell: UITableViewCell {
    
    var trackInfo: Track! {
        
        didSet {
            
            if let price = trackInfo.trackPrice {
                
                buyButton.setTitle("$\(price)", forState: .Normal)
                
            } else {
                
                buyButton.hidden = true
                
            }
            
        }
        
    }
    
    @IBOutlet weak var buyButton: UIButton!

    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var playButton: SVGPlayButton!
    
    @IBAction func pressedPlayButton(sender: SVGPlayButton) {
        
        print("pressed")
        
    }
    
    @IBAction func pressedBuyButton(sender: AnyObject) {
        
        if let urlString = trackInfo.trackViewURL {
            
            print(urlString)
            
            if let url = NSURL(string: urlString) {
                
                UIApplication.sharedApplication().openURL(url)
                
            }
            
        }
        
        
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
    
    var player: AVAudioPlayer?
    
    private func willPlayHandler() {
        
        if let data = trackInfo.mediaData ?? trackInfo.getMedia() {
            
            player = player ?? (try? AVAudioPlayer(data: data))
            
        }
        
        player?.play()
        
        print("willPlay")
        
    }
    
    private func willPauseHandler() {
        
        player?.pause()
        print("willPause")
        
    }
    

}
