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

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtnClicked() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: [], from: self) { (result, error) -> Void in
            if let error = error {
                Toast(text: "error : \(error)").show()
                return
            }
            
            if result!.isCancelled {
                Toast(text: "cancelled").show()
            } else {
                self.login(result!.token.userID)
            }
        }
    }
    
    func login(_ facebookId: String) {
        ServerClient.login(facebookId: facebookId, name: "김현섭") { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true)
                } else {
                    Toast(text: "login error").show()
                }
            }
        }
    }
}
