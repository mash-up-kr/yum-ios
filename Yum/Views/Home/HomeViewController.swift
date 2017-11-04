//
//  HomeViewController.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private var feedCellForEstimatedHeight: FeedCell!
    
    private var feeds: [Feed] = Feed.sampleFeeds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFeedCellForEstimatedHeight()
    }
    
}

// MARK: - HomeViewController - Private Methods

extension HomeViewController {
    
    private func initFeedCellForEstimatedHeight() {
        feedCellForEstimatedHeight = tableView.dequeueReusableCell(FeedCell.self)
        feedCellForEstimatedHeight.frame = view.frame
        feedCellForEstimatedHeight.isHidden = true
        feedCellForEstimatedHeight.forEstimatedHeight = true
        view.addSubview(feedCellForEstimatedHeight)
    }
    
}

// MARK: - HomeViewController - UITableView

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        feedCellForEstimatedHeight.feed = feeds[indexPath.row]
        return feedCellForEstimatedHeight.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        feedCellForEstimatedHeight.feed = feeds[indexPath.row]
        return feedCellForEstimatedHeight.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedCell.self, indexPath: indexPath)
        cell.feed = feeds[indexPath.row]
        return cell
    }
    
}
