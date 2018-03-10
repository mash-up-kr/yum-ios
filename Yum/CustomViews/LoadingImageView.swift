//
//  LoadingImageView.swift
//  Noverish Harold
//
//  Created by Noverish Harold on 2018. 3. 7..
//  Copyright © 2018 Noverish Harold. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LoadingImageView: UIImageView {

    private var indicator: UIActivityIndicatorView?
    private var nowLoadingNum = 0
    var imageUrl: String? {
        didSet {
            if self.imageUrl == oldValue {
                return
            }
            
            self.image = nil
            guard let imageUrl = self.imageUrl else {
                return
            }

            if indicator == nil {
                let indicator = UIActivityIndicatorView(frame: self.bounds)
                indicator.color = .black
                indicator.startAnimating()
                self.addSubview(indicator)
                self.indicator = indicator
            }

            self.nowLoadingNum += 1
            Alamofire.request(imageUrl).responseImage { response in
                DispatchQueue.main.async {
                    self.nowLoadingNum -= 1
                    if self.nowLoadingNum != 0 {
                        return
                    }

                    self.indicator?.removeFromSuperview()
                    self.indicator = nil

                    if let image = response.result.value {
                        UIView.transition(with: self,
                                          duration: 0.4,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = image },
                                          completion: nil)
                    }
                }
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        indicator?.frame = self.bounds
    }
}
