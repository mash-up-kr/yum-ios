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
    
    @IBOutlet weak var feedCellContainer: UIView!
    @IBOutlet weak var feedCellContainerHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cell = UINib.load2(FeedCell.self)
        cell.feed = feed
        cell.height = cell.calcCellHeight(width: self.view.width)
        feedCellContainerHeight.constant = cell.height
        feedCellContainer.addSubview(cell)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
}
