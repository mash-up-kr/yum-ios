//
//  CrashUtil.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 10..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import Foundation
import Toaster

class CrashUtil {
    static func process(_ error: Error?) {
        if let serverError = error as? ServerError {
            Toast(text: serverError.msg).show()
            return
        }
    
        Toast(text: String(describing: error)).show()
    }
}
