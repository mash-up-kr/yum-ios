//
//  UIStoryboard+Yum.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<VC: UIViewController>() -> VC {
        return instantiateViewController(withIdentifier: VC.className) as! VC // swiftlint:disable:this force_cast
    }
    
}
