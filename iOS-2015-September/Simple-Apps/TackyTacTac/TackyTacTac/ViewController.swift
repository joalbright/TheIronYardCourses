//
//  ViewController.swift
//  TackyTacTac
//
//  Created by Jo Albright on 9/25/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

// reset scores
// reset board
// chosen space

class ViewController: UIViewController {
    
    var grid = [[0,0,0],[0,0,0],[0,0,0]]
    // grid[0][0] = grid[row][col]
    
    var isPlayer1Turn = true
    
    var player1Score = 0
    var player2Score = 0
    var stalemateScore = 0
    
    let gameStatusLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.whiteColor()
        
        gameStatusLabel.text = "Player 1 Turn"
        gameStatusLabel.textAlignment = .Center
        
        gameStatusLabel.center.x = view.center.x
        
        view.addSubview(gameStatusLabel)
        
        // grid[0]
        
        let screenHeight = Int(UIScreen.mainScreen().bounds.height)
        let screenWidth = Int(UIScreen.mainScreen().bounds.width)
        
        let buttonHW = 100
        let buttonSpacing = 4
        
        let gridHW = (buttonHW * 3) + (buttonSpacing * 2)
        
        let leftSpacing = (screenWidth - gridHW) / 2
        let topSpacing = (screenHeight - gridHW) / 2
        
        for (r,row) in grid.enumerate() {
            
            for (c,_) in row.enumerate() {
                
                let x = c * (buttonHW + buttonSpacing) + leftSpacing
                let y = r * (buttonHW + buttonSpacing) + topSpacing
                
                let button = TTTButton(frame: CGRect(x: x, y: y, width: buttonHW, height: buttonHW))
                button.backgroundColor = UIColor.cyanColor()
                
                button.row = r
                button.col = c
                
                button.addTarget(self, action: "spacePressed:", forControlEvents: .TouchUpInside)
                view.addSubview(button)
                
            }
            
        }
        
        //        let button1 = TTTButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //        button1.backgroundColor = UIColor.cyanColor()
        //
        ////        button1.tag = 0
        //        button1.row = 0
        //        button1.col = 0
        //
        //        button1.addTarget(self, action: "spacePressed:", forControlEvents: .TouchUpInside)
        //        view.addSubview(button1)
        //
        //        let button2 = TTTButton(frame: CGRect(x: 110, y: 0, width: 100, height: 100))
        //        button2.backgroundColor = UIColor.cyanColor()
        //
        //        //        button1.tag = 0
        //        button2.row = 0
        //        button2.col = 1
        //
        //        button2.addTarget(self, action: "spacePressed:", forControlEvents: .TouchUpInside)
        //        view.addSubview(button2)
        
        
    }
    
    func spacePressed(button: TTTButton) {
        
        if button.player == 0 {
            
            
            //            if isPlayer1Turn {
            //
            //                button.player = 1
            //
            //            } else {
            //
            //                button.player = 2
            //
            //            }
            
            button.player = isPlayer1Turn ? 1 : 2
            
            grid[button.row][button.col] = isPlayer1Turn ? 1 : 2
            
            isPlayer1Turn = !isPlayer1Turn
            
            checkForWinner()
            
        }
        
        //        print("button works")
        
    }
    
    func checkForWinner() {
        
        // r,c
        
        // row 1    0,0 0,1 0,2
        // row 2    1,0 1,1 1,2
        // row 3    2,0 2,1 2,2
        // col 1    0,0 1,0 2,0
        // col 2    0,1 1,1 2,1
        // col 3    0,2 1,2 2,2
        // dia 1    0,0 1,1 2,2
        // dia 2    2,0 1,1 0,2
        
        let possibilities = [
            
            ((0,0),(0,1),(0,2)),
            ((1,0),(1,1),(1,2)),
            ((2,0),(2,1),(2,2)),
            ((0,0),(1,0),(2,0)),
            ((0,1),(1,1),(2,2)),
            ((1,2),(1,2),(2,2)),
            ((0,0),(1,1),(2,2)),
            ((2,0),(1,1),(0,2))
            
        ]
        
        for possibility in possibilities {
            
            let (p1,p2,p3) = possibility
            
            let value1 = grid[p1.0][p1.1]
            let value2 = grid[p2.0][p2.1]
            let value3 = grid[p3.0][p3.1]
            
            if value1 == value2 && value2 == value3 {
                
                if value1 != 0 {
                    
                    // someone won
                    print("Player \(value1) Wins")
                    
                    
                    
                    
                } else {
                    
                    print("all zeros")
                    
                }
                
            } else {
                
                print("does not match")
                
            }
            
        }
        
    }
    
}

class TTTButton: UIButton {
    
    var row = 0
    var col = 0
    
    var player = 0 {
        
        didSet {
            
            switch player {
                
            case 1 : backgroundColor = UIColor.magentaColor()
            case 2 : backgroundColor = UIColor.yellowColor()
            default : backgroundColor = UIColor.cyanColor()
                
            }
            
        }
        
    }
    
}