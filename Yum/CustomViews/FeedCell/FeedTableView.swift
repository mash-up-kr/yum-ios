//
//  FeedTableView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 6..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class FeedTableView: UITableView {
    private let NIB_NAME = String(describing: FeedCell.self)

    private var estimateCell: FeedCell!
    private weak var vc: UIViewController!

    var feeds: [Feed] = [] {
        didSet {
            self.reloadData()
        }
    }

    func initiate(_ vc: UIViewController) {
        self.vc = vc

        guard let cell = Bundle.main.loadNibNamed(NIB_NAME, owner: nil, options: nil)?.first as? FeedCell else {
            fatalError()
        }

        self.estimateCell = cell
        self.estimateCell.isEstimateCell = true
        self.separatorStyle = .none
        self.allowsSelection = false
        self.allowsMultipleSelection = false
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: NIB_NAME, bundle: nil), forCellReuseIdentifier: NIB_NAME)
    }
}

extension FeedTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NIB_NAME, for: indexPath) as? FeedCell else {
            fatalError()
        }

        cell.vc = vc
        cell.feed = feeds[safe: indexPath.row]

        return cell
    }
}

extension FeedTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        estimateCell.feed = feeds[safe: indexPath.row]
        return estimateCell.calcCellHeight(width: self.width)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650
    }
}
