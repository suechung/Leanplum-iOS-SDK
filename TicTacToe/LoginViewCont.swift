//
//  LoginViewCont.swift
//  TicTacToe
//
//  Created by Sue Chung on 3/14/18.
//  Copyright © 2018 Sue Chung. All rights reserved.
//

import UIKit
import Leanplum
import UserNotifications

// Leanplum variables
var kitty = LPVar.define("kitty", withFile: "kitty.jpg") // background image
var gameName = LPVar.define("gameName", with: "TicTacToe") // string example
var showAds = LPVar.define("showAds", with: false) // boolean example


class LoginViewCont : UIViewController {
    
    var n_user: userLogin? = nil
    
    @IBOutlet weak var pushOptin: UISwitch!
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // sets userID
    func setUserId(userId: String){
        if(Leanplum.hasStarted()){
            Leanplum.setUserId(userId)
            
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Init the userID if necessary
        if(n_user == nil){
            n_user = userLogin()
        }
        
        if let newUserID = userTextField.text{
            //Set the UserID & call the basic push setup
            n_user?.userID = newUserID
            setUserId(userId:newUserID)
        }
        
        performSegue(withIdentifier: "loadGame", sender: self)
        Leanplum.track("login") // Leanplum track event "login"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var secondController = segue.destination as! ViewController
        secondController.myString = userTextField.text!
    }
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var gameRename: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newImage.image = kitty?.imageValue()
        gameRename.text = gameName?.stringValue()

        // Callback for setting image
        Leanplum.onVariablesChangedAndNoDownloadsPending {

        }
        
    }
    
}
