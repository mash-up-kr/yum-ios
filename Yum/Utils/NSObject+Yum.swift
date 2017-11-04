//
//  NSObject+Yum.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import Foundation

extension NSObject {
    
    public class var className: String { return String(describing: self) }
    
    public var className: String { return type(of: self).className }
    
}

