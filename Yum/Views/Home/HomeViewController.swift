//
//  HomeViewController.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var cellForEstimate: FeedCellContent!

    @IBOutlet private weak var tableView: FeedTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleImageView = UIImageView(image: #imageLiteral(resourceName:"navi-logo"))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.frame = CGRect(x: -30, y: -16, width: 60, height: 32)
        let view = UIView(frame: CGRect.zero)
        view.addSubview(titleImageView)
        navigationItem.titleView = view

        tableView.initiate(self)

        ServerClient.getFeedList { feeds in
            DispatchQueue.main.async {
                self.tableView.feeds = feeds
            }
        }
    }
}
