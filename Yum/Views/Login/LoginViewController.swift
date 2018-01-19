//
//  LoginViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 1. 18..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtnClicked() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: [], from: self) { (result, error) -> Void in
            if let error = error {
                print("error : \(error)")
                return
            }
            
            if result!.isCancelled {
                print("cancelled")
            } else {
                print("token \(result!.token.userID!)")
                self.dismiss(animated: true)
            }
        }
    }
}
