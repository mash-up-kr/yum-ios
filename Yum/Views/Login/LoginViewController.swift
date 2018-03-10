//
//  LoginViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 1. 18..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Toaster
import SwiftyJSON

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtnClicked() {
        LoginManager.login(self) { userID, name in
            self.login(userID, name)
        }
    }
    
    func login(_ facebookId: String, _ name: String) {
        ServerClient.login(facebookId: facebookId, name: name) { error in
            if let error = error {
                CrashUtil.process(error)
                return
            }

            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
}
