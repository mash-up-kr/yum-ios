//
//  FeedCell.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit
import ManualLayout
import Alamofire
import AlamofireImage

final class FeedCell: UITableViewCell {
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UIButton!
    @IBOutlet weak var foodImageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var calorieContainerView: UIView!
    @IBOutlet weak var calorieButton: UIButton!
    
    @IBOutlet weak var tag1ContainerView: UIView!
    @IBOutlet weak var tag1Button: UIButton!
    
    @IBOutlet weak var tag2ContainerView: UIView!
    @IBOutlet weak var tag2Button: UIButton!
    
    @IBOutlet weak var tag3ContainerView: UIView!
    @IBOutlet weak var tag3Button: UIButton!
    
    public var forEstimatedHeight: Bool = false
    public var feed: Feed? {
        didSet {
            userNameLabel.setTitle(feed?.userName, for: .normal)
            bodyLabel.text = feed?.body
            
            if !forEstimatedHeight {
                loadUserProfileImage(userProfileImageUrl: feed?.userProfileImageUrl)
                loadFoodImage(foodImageUrl: feed?.foodImageUrl)
            }
        }
    }
    
    private var isUserProfileImageLoading: Bool = false
    private var userProfileImageUrlInLoading: String?
    
    private var isFoodImageLoading: Bool = false
    private var foodImageUrlInLoading: String?
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInitialization()
        initViewProperties()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitialization()
        initViewProperties()
    }
    
}

extension FeedCell {
    
    private func commonInitialization() {
        let view = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as! UIView // swiftlint:disable:this force_cast
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func initViewProperties() {
        userProfileImageView.layer.cornerRadius = 18
        userProfileImageView.layer.masksToBounds = true
        
        calorieContainerView.layer.cornerRadius = 15
        calorieContainerView.layer.masksToBounds = true
        
        tag1ContainerView.layer.cornerRadius = 15
        tag1Button.layer.masksToBounds = true
        
        tag2ContainerView.layer.cornerRadius = 15
        tag2Button.layer.masksToBounds = true
        
        tag3ContainerView.layer.cornerRadius = 15
        tag3Button.layer.masksToBounds = true
    }
    
    private func loadUserProfileImage(userProfileImageUrl: String?) {
        guard let userProfileImageUrl = userProfileImageUrl else {
            userProfileImageView.image = #imageLiteral(resourceName: "sample-user-profile-image") // TODO: set default image
            return
        }
        self.userProfileImageView.image = nil // TODO: set default image
        userProfileImageUrlInLoading = userProfileImageUrl
        Alamofire.request(userProfileImageUrl).responseImage { response in
            guard self.userProfileImageUrlInLoading == userProfileImageUrl else {
                return
            }
            guard let image = response.result.value else {
                self.userProfileImageView.image = #imageLiteral(resourceName: "sample-user-profile-image") // TODO: set default image
                return
            }
            self.userProfileImageView.image = image
            self.userProfileImageUrlInLoading = nil
        }
    }
    
    private func loadFoodImage(foodImageUrl: String?) {
        guard let foodImageUrl = foodImageUrl else {
            self.foodImageView.image = #imageLiteral(resourceName: "sample-user-profile-image") // TODO: set error image
            return
        }
        startActivityIndicator()
        foodImageUrlInLoading = foodImageUrl
        Alamofire.request(foodImageUrl).responseImage { response in
            guard self.foodImageUrlInLoading == foodImageUrl else {
                return
            }
            defer { self.stopActivityIndicator() }
            guard let image = response.result.value else {
                self.foodImageView.image = #imageLiteral(resourceName: "sample-user-profile-image") // TODO: set error image
                return
            }
            self.foodImageView.image = image
            self.foodImageUrlInLoading = nil
        }
    }
    
    private func startActivityIndicator() {
        foodImageActivityIndicator.startAnimating()
        foodImageView.isHidden = true
    }
    
    private func stopActivityIndicator() {
        foodImageActivityIndicator.stopAnimating()
        foodImageView.isHidden = false
    }
    
}

extension FeedCell {
    
    public var cellHeight: CGFloat {
        setNeedsLayout()
        layoutIfNeeded()
        return containerStackView.height
    }
    
}
