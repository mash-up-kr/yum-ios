//
//  FeedViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    var feed: Feed!

    @IBOutlet private weak var feedCellContent: FeedCellContent!
    @IBOutlet private weak var feedCellContentHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        feedCellContent.feed = feed
        feedCellContent.sizeToFit()
        feedCellContentHeight.constant = feedCellContent.height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
}
