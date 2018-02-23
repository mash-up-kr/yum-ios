//
//  LoginManager.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 23..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

class LoginManager {

    static var isLogin: Bool {
        get {
            return FBSDKAccessToken.current() != nil
        }
    }

    static func login(_ vc: UIViewController, callback: ((String, String) -> Void)? = nil) {
        if let token = FBSDKAccessToken.current() {
            getUserName { name in
                callback?(token.userID, name)
            }
        } else {
            getUserID(vc) { userID in
                getUserName { name in
                    callback?(userID, name)
                }
            }
        }
    }

    private static func getUserID(_ vc: UIViewController, callback: ((String) -> Void)? = nil) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile"], from: vc) { (result, error) -> Void in
            if let _ = error {
                return
            }

            if result!.isCancelled {

            } else {
                callback?(result!.token.userID)
            }
        }
    }

    private static func getUserName(callback: ((String) -> Void)? = nil) {
        let parameters = ["fields": "first_name, last_name"]

        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) in
            let json = JSON(result!)
            let name: String = json["last_name"].stringValue + json["first_name"].stringValue
            callback?(name)
        })
    }
}
