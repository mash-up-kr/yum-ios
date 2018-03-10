//
//  FeedTableView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 3. 6..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class FeedTableView: UITableView {
    private let NIB_NAME = String(describing: FeedCellContent.self)

    private weak var vc: UIViewController!
    private var estimateView: FeedCellContent!

    var feeds: [Feed] = [] {
        didSet {
            self.reloadData()
        }
    }

    func initiate(_ vc: UIViewController) {
        self.vc = vc
        self.estimateView = FeedCellContent(frame: self.bounds)
        self.estimateView.isEstimateView = true
        
        self.separatorStyle = .none
        self.allowsSelection = false
        self.allowsMultipleSelection = false
        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: NIB_NAME)
    }
}

extension FeedTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NIB_NAME, for: indexPath)

        if cell.contentView.subviews.count == 0 {
            let view = FeedCellContent(frame: self.bounds)
            cell.contentView.addSubview(view)
        }

        guard let view = cell.contentView.subviews.first as? FeedCellContent else {
            return cell
        }

        view.feed = feeds[indexPath.row]
        view.openDetailWhenClicked = true
        view.vc = self.vc
        view.y = 0 // TODO I don't know why this is necessary
        view.sizeToFit()

        return cell
    }
}

extension FeedTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let feed = feeds[indexPath.row]

        if estimateView.feed?.feedId != feed.feedId {
            estimateView.feed = feed
            estimateView.sizeToFit()
        }

        return estimateView.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650
    }
}
