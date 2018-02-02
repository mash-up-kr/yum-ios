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

extension UIViewController {
    
    func keyboardHeight(from notification: NSNotification) -> CGFloat? {
        return (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
    
    func keyboardAnimationDuration(from notification: NSNotification) -> Double? {
        return notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
    }
}

extension UIViewController {
    func hideKeyboardWhenTap() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
