//: Playground - noun: a place where people can play

import UIKit
import AVFoundation

extension AVAudioPlayer {
    
    enum AssetIdentifier: String { case Pop,Ping,Bang }
    enum AssetError: ErrorType { case AssetNotFound,AssetBadData }
    
    convenience init(assetIdentifier: AssetIdentifier) throws {
        
        guard let file = NSDataAsset(name: assetIdentifier.rawValue) else { throw AssetError.AssetNotFound }
        try self.init(data: file.data)
        
    }
    
}

class Controller: UIViewController, AVAudioPlayerDelegate {
    
    var players = [AVAudioPlayer]()
    
    func playSound(name: AVAudioPlayer.AssetIdentifier) {
        
        if let player = try? AVAudioPlayer(assetIdentifier: name) {
            
            player.delegate = self
            player.play()
            players.append(player)
            
        }
        
    }
    
}

