//
//  TabBarController.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
}

// MARK: - TabBarController: UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is DummyViewController:
            present(HomeNavigationController.instantiate(), animated: true, completion: nil) // TODO: 이와 같이 쓰기 화면 호출
            return false
        default:
            return true
        }
    }
    
}
