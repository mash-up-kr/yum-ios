//
//  FeedCell.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 6..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import Toaster

class FeedCellContent: UIView {

    let HEART_ON = #imageLiteral(resourceName:"btn-heart-on")
    let HEART_OFF = #imageLiteral(resourceName:"btn-heart-off")

    @IBOutlet private weak var rootWidth: NSLayoutConstraint!
    @IBOutlet private weak var profileImageView: LoadingImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var heartBtn: UIButton!
    @IBOutlet private weak var reportBtn: UIButton!
    @IBOutlet private weak var mainImageView: LoadingImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var tagListView: TagListView!
    @IBOutlet private weak var tagListViewHeight: NSLayoutConstraint!

    var isEstimateView = false
    var openDetailWhenClicked = false
    var vc: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        let view = UIView.loadFromNib("FeedCellContent", owner: self)
        view.frame = self.bounds
        self.addSubview(view)

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        self.profileImageView.layer.cornerRadius = profileImageView.width / 2
        self.profileImageView.layer.masksToBounds = true
    }

    var feed: Feed? {
        didSet {
            guard let feed = feed else {
                return
            }
            
            userNameLabel.text = feed.userName

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

            if !isEstimateView {
                profileImageView.setImageUrl(feed.userProfileImageUrl)
                heartBtn.setImage(feed.isLike ? HEART_ON : HEART_OFF, for: .normal)
                mainImageView.setImageUrl(feed.foodImageUrl)
            }
        }
    }

    @objc func clicked() {
        if !openDetailWhenClicked {
            return
        }

        let vc = UIStoryboard.instantiate(FeedViewController.self)
        vc.feed = self.feed
        self.vc?.present(vc, animated: true)
    }

    @IBAction func heartBtnClicked() {
        guard let feed = self.feed else {
            return
        }
        
        self.feed?.isLike = !feed.isLike
        heartBtn.setImage(feed.isLike ? HEART_ON : HEART_OFF, for: .normal)

        ServerClient.toggleFeedLike(feedId: feed.feedId) { _ in

        }
    }

    @IBAction func reportBtnClicked() {
        vc?.showYesNoAlertView(title: "게시물 신고", content: "게시물을 신고하시겠습니까?") { yes in
            if yes {
                Toast(text: "신고되었습니다.").show()
            }
        }
    }

    override func sizeToFit() {
        self.rootWidth.constant = self.width
        self.height = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}
