//
//  Extensions+Yum.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 5..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib(_ nibName: String) {
        guard let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("There is no nib whose name is '\(nibName)'")
        }
        
        view.frame = bounds
        addSubview(view)
    }
}

extension UIView {
    var x: CGFloat {
        set(v) {
            self.frame.origin.x = v
        }
        get {
            return self.frame.origin.x
        }
    }

    var y: CGFloat {
        set(v) {
            self.frame.origin.y = v
        }
        get {
            return self.frame.origin.y
        }
    }

    var height: CGFloat {
        set(v) {
            self.frame.size.height = v
        }
        get {
            return self.frame.height
        }
    }

    var width: CGFloat {
        set(v) {
            self.frame.size.width = v
        }
        get {
            return self.frame.width
        }
    }
}

// https://stackoverflow.com/a/30450559
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

//from http://stackoverflow.com/a/30593673
extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIStoryboard {
    static func instantiate<T: UIViewController>(_ type: T.Type, storyboardName: String? = nil) -> T {
        let name = String(describing: type)
        let storyboardName = storyboardName ?? name
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name)
        
        guard let vc2 = vc as? T else {
            fatalError("Cannot cast '\(vc)' to '\(name)'")
        }
        
        return vc2
    }
}

extension UIView {
    static func loadFromNib(_ name: String, owner: Any? = nil) -> UIView {
        guard let nib = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?.first else {
            fatalError("Cannot load nib whose type is '\(name)'")
        }

        guard let v = nib as? UIView else {
            fatalError("Cannot cast '\(nib)' to '\(name)'")
        }

        return v
    }
}

extension UIViewController {
    func showYesNoAlertView(title: String = "", content: String = "", callback: ((Bool) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            callback?(true)
        }
        alert.addAction(yesAction)

        let noAction = UIAlertAction(title: "No", style: .default) { _ in
            callback?(false)
        }
        alert.addAction(noAction)

        self.present(alert, animated: true)
    }
}
