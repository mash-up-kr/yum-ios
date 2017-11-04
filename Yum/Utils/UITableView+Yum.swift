//
//  UITableView+Yum.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type) -> Cell {
        return self.dequeueReusableCell(withIdentifier: cellType.className) as! Cell // swiftlint:disable:this force_cast
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type, indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as! Cell // swiftlint:disable:this force_cast
    }
    
}
