//
//  ViewController.swift
//  TicTacToeLayout
//
//  Created by Jo Albright on 5/8/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var spaces: [[Player?]] = [
    
        [nil,nil,nil],
        [nil,nil,nil],
        [nil,nil,nil]
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var currentPlayer: Player = .One

    @IBAction func buttonPressed(sender: TButton) {
        
        if sender.player != nil { return }
        
        sender.player = currentPlayer
        sender.setNeedsDisplay()
        
        spaces[sender.row][sender.col] = currentPlayer
        
        println(spaces)
        
        checkForWinner()
        
//        if currentPlayer == .One {
//            
//            currentPlayer = .Two
//            
//        } else {
//            
//            currentPlayer = .One
//            
//        }
        
        currentPlayer = (currentPlayer == .One) ? .Two : .One
        
    }
    
    var possibilities = [
        [0,0,0,1,0,2],
        [1,0,1,1,1,2],
        [2,0,2,1,2,2],
    ]
    
    func checkForWinner() {
        
        for possibility in possibilities {
            
            let firstSpot = spaces[possibility[0]][possibility[1]]
            let secondSpot = spaces[possibility[2]][possibility[3]]
            let thirdSpot = spaces[possibility[4]][possibility[5]]
            
            if firstSpot == secondSpot && secondSpot == thirdSpot {
                
                if let winner = firstSpot {
                    
                    println("player \(winner.hashValue + 1) wins")
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
}




