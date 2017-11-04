//
//  UIViewController+Yum.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> Self {
        return UIStoryboard(name: className, bundle: nil).instantiateViewController()
    }
    
}
