//
//  UIImageView+Yum.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    func setImageUrl(_ url: String, callback: ((Bool) -> Void)? = nil) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                self.image = image
                callback?(true)
            } else {
                callback?(false)
            }
        }
    }
}
