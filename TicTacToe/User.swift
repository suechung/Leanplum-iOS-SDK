//
//  User.swift
//  TicTacToe
//
//  Created by Sue Chung on 3/15/18.
//  Copyright © 2018 Sue Chung. All rights reserved.
//

import Foundation
import Leanplum
#if DEBUG
    import AdSupport
#endif

import UserNotifications

class userLogin{

    var pushEnabled = false
    var n_userID = ""

    var userID: String{
        get{
            return n_userID
        }
        set{
            n_userID = newValue
        }
    }

    var pushIsEnabled: Bool{
        get {
            return pushEnabled
        }
        set {
            pushEnabled = newValue
        }
    }


}
