//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sue Chung on 3/13/18.
//  Copyright © 2018 Sue Chung. All rights reserved.
//

import UIKit
import UserNotifications
import Leanplum

class ViewController: UIViewController {
    
    @IBOutlet weak var greetUser: UILabel!
    
    var myString = String()
    
    @IBOutlet weak var WinnerLabel: UILabel!

    @IBOutlet weak var ResetButton: UIButton!
    
    // check if marked: 0 is empty, 1 is nought, 2 is cross
    var GameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var numofPlays = 1
    var winner = 0
    var Winning = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBAction func ButtonPressed(_ sender: AnyObject) {

        if GameState[sender.tag-1] == 0 && winner == 0 {
            // odd number play is cross, even is nought
            if numofPlays % 2 == 0 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                GameState[sender.tag-1] = 2
                print(GameState)
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                GameState[sender.tag-1] = 1
                print(GameState)
            }
        
            for combo in Winning
            {
                if GameState[combo[0]] != 0 && GameState[combo[0]] == GameState[combo[1]] &&
                    GameState[combo[1]] == GameState[combo[2]] {
                    winner = GameState[combo[0]]
                }
            }
        }
        
                if winner == 2 {
                    WinnerLabel.text = "Nought won!"
                    WinnerLabel.isHidden = false
                    ResetButton.isHidden = false
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.WinnerLabel.center = CGPoint(x: self.WinnerLabel.center.x + 500, y: self.WinnerLabel.center.y)
                        self.ResetButton.center = CGPoint(x: self.ResetButton.center.x + 500, y: self.ResetButton.center.y)
                    })
                    
                    Leanplum.track("game completed")
                    
                    //set Leanplum User attribute
                    Leanplum.setUserAttributes(["Played game?":true])
                    
                }
                
                if winner == 1 {
                    WinnerLabel.text = "Cross won!"
                    WinnerLabel.isHidden = false
                    ResetButton.isHidden = false
                    
                    Leanplum.track("game completed")
                    Leanplum.setUserAttributes(["Played game?":true])
                
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.WinnerLabel.center = CGPoint(x: self.WinnerLabel.center.x + 500, y: self.WinnerLabel.center.y)
                        self.ResetButton.center = CGPoint(x: self.ResetButton.center.x + 500, y: self.ResetButton.center.y)
                        
                    })
                
                }
    
            numofPlays = numofPlays + 1

            if numofPlays == 10 && winner == 0 {
                WinnerLabel.text = "It's a tie!"
                WinnerLabel.isHidden = false
                ResetButton.isHidden = false
                Leanplum.track("game completed")
                
                UIView.animate(withDuration: 1, animations: {
                    self.WinnerLabel.center = CGPoint(x: self.WinnerLabel.center.x + 500, y: self.WinnerLabel.center.y)
                    self.ResetButton.center = CGPoint(x: self.ResetButton.center.x + 500, y: self.ResetButton.center.y)
                })
                
            }

    }
    
        @IBAction func ResetButton(_ sender: Any) {
            winner = 0
            GameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
            numofPlays = 1
    
            for i in 1..<10 {
                if let button = view.viewWithTag(i) as? UIButton {
                    button.setImage(nil, for: [])
                }
            }
    
            WinnerLabel.isHidden = true
            ResetButton.isHidden = true
    
            WinnerLabel.center = CGPoint(x: WinnerLabel.center.x - 500, y: WinnerLabel.center.y)
            ResetButton.center = CGPoint(x: ResetButton.center.x - 500, y: ResetButton.center.y)
    
        }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        WinnerLabel.isHidden = true
        ResetButton.isHidden = true

        WinnerLabel.center = CGPoint(x: WinnerLabel.center.x - 500, y: WinnerLabel.center.y)
        ResetButton.center = CGPoint(x: ResetButton.center.x - 500, y: ResetButton.center.y)
        
        greetUser.text = "Hello " + myString
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

