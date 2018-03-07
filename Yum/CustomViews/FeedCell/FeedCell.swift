//
//  FeedCell.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 6..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet private weak var rootWidth: NSLayoutConstraint!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var heartBtn: UIButton!
    @IBOutlet private weak var reportBtn: UIButton!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var tagListView: TagListView!
    @IBOutlet private weak var tagListViewHeight: NSLayoutConstraint!

    var isEstimateCell: Bool = false
    var vc: UIViewController!
    var feed: Feed? = nil {
        didSet {
            guard let feed = feed else {
                return
            }

            let content = feed.userName + "  " + feed.body
            let attributedString = NSMutableAttributedString(string: content, attributes: [
                .font: UIFont(name: "NanumSquareOTFR", size: 12)!,
                .foregroundColor: UIColor(white: 0, alpha: 1)
            ])
            attributedString.addAttribute(.font, value: UIFont(name: "NanumSquareOTFB", size: 12)!, range: NSRange(location: 0, length: feed.userName.count + 2))

            contentLabel.attributedText = attributedString
            tagListView.calorie = feed.calorie
            tagListView.tags = feed.tags
            tagListViewHeight.constant = tagListView.estimatedHeight

            if !isEstimateCell {
                userNameLabel.text = feed.userName
                profileImageView.setImageUrl(feed.userProfileImageUrl)
                mainImageView.setImageUrl(feed.foodImageUrl)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        self.profileImageView.layer.cornerRadius = profileImageView.width / 2
        self.profileImageView.layer.masksToBounds = true
    }

    @objc func clicked() {
        let vc = UIStoryboard.instantiate(FeedViewController.self)
        vc.feed = self.feed
        self.vc.present(vc, animated: true)
    }

    func calcCellHeight(width: CGFloat) -> CGFloat {
        self.rootWidth.constant = width
        return self.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}
