//
//  LoadingImageView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 7..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LoadingImageView: UIImageView {

    private var imageUrl: String?
    private var indicator: UIActivityIndicatorView?
    private var nowLoadingNum = 0

    func setImageUrl(_ url: String) {
        if self.imageUrl == url {
            return
        }

        self.imageUrl = url
        self.nowLoadingNum += 1
        self.image = nil

        let indicator = UIActivityIndicatorView(frame: self.bounds)
        indicator.color = .black
        indicator.startAnimating()
        self.addSubview(indicator)
        self.indicator = indicator

        Alamofire.request(url).responseImage { response in
            DispatchQueue.main.async {
                self.nowLoadingNum -= 1

                if self.nowLoadingNum != 0 {
                    return
                }

                if let image = response.result.value {
                    self.indicator?.removeFromSuperview()
                    UIView.transition(with: self,
                                      duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: { self.image = image },
                                      completion: nil)
                } else {
                    
                }
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        indicator?.frame = self.bounds
    }
}
