//
//  TabBarController.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        DispatchQueue.main.async {
            if LoginManager.isLogin {
                LoginManager.login(self) { userID, name in
                    ServerClient.login(facebookId: userID, name: name)
                }
            } else {
                self.present(LoginViewController.instantiate(), animated: false)
            }
        }
    }
}

// MARK: - TabBarController: UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is DummyViewController:
            present(PostViewController.instantiate(), animated: false, completion: nil)
            return false
        case is MyNavigtaionController:
            if let nav = viewController as? MyNavigtaionController,
                let vc = nav.topViewController as? MyViewController {
                vc.userName = ServerClient.userName
            }
            return true
        default:
            return true
        }
    }
}
