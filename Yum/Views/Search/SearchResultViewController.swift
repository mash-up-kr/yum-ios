//
//  SearchResultViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

final class SearchResultViewController: UIViewController {
    var startCalorie: Int!
    var endCalorie: Int!
    var tag: String?
    var userName: String?
    
    @IBOutlet private weak var tableView: FeedTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.initiate(self)

        ServerClient.search(startCalorie: startCalorie, endCalorie: endCalorie, tag: tag, userName: userName) { feeds, error in
            guard let feeds = feeds else {
                CrashUtil.process(error)
                return
            }

            DispatchQueue.main.async {
                self.tableView.feeds = feeds
            }
        }
    }

    @IBAction func backBtnClicked() {
        self.navigationController?.dismiss(animated: true)
    }
}
