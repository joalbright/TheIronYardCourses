//
//  AlbumDetailViewController.swift
//  AlbumArt
//
//  Created by Jo Albright on 10/13/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import AFNetworking

class AlbumDetailViewController: UIViewController {

    var albumInfo: Album!
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    
    let tracksData = TracksDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracksTableView.dataSource = tracksData

        albumNameLabel.text = albumInfo.albumName
        albumImageView.image = albumInfo.albumImage ?? albumInfo.getImage()
    
        albumImageView.contentMode = .ScaleAspectFill
        
        
        print(albumInfo.albumID)
        
        if let albumID = albumInfo.albumID {
            
            print(albumID)
            
            tracksData.findTracksForAlbum("\(albumID)", completion: { () -> () in
                
                // update tableView
                self.tracksTableView.reloadData()
                
            })
            
        }
        
        
    }

}

class TracksDataSource: NSObject, UITableViewDataSource {
    
    var tracks: [Track] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tracks.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell", forIndexPath: indexPath) as! TrackCell
        
        let track = tracks[indexPath.row]
        
        cell.trackNameLabel.text = track.trackName
        
        return cell
        
    }
    
    let requestManager = AFHTTPRequestOperationManager()
    
    func findTracksForAlbum(albumID: String, completion: () -> ()) {
        
        tracks = []
        
        let urlString = "https://itunes.apple.com/lookup?id=\(albumID)&entity=song"
        
        print(urlString)
        
        requestManager.GET(urlString, parameters: nil, success: { (operation, data) -> Void in
            
            if let foundInfo = data as? Dictionary {
                
                if let results = foundInfo["results"] as? [Dictionary] {
                    
                    for result in results {
                        
                        if result["trackName"] != nil {
                            
                            let track = Track(info: result)
                            self.tracks.append(track)
                            
                        }
                        
                    }
                    
                    completion()
                    
                }
                
            }
            
            print(data)
            
        }) { (operation, error) -> Void in
            
            print(error)
            
        }
        
    }
    
}

class Track: NSObject {
    
    var trackName: String?
    var trackNumber: Int?
    var trackPrice: String?
    var mediaURL: String?
    
    init(info: Dictionary) {
        
        trackName = info["trackName"] as? String
        trackNumber = info["trackNumber"] as? Int
        trackPrice = info["trackPrice"] as? String // could be Double
        mediaURL = info["previewUrl"] as? String
        
    }
    
}












