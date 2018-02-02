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
    
    @IBOutlet weak var feedCell: FeedCell!
    @IBOutlet weak var feedCellHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedCell.feed = feed
        feedCellHeight.constant = feedCell.cellHeight
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
}
