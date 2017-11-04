//
//  SearchViewContoller.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 4..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import UIKit

final class SearchViewContoller: UITableViewController {
    
    private var feedCellForEstimatedHeight: FeedCell!
    
    private var feeds: [Feed] = Feed.sampleFeeds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFeedCellForEstimatedHeight()
        refreshControl?.addTarget(self, action: #selector(SearchViewContoller.refreshingDidChange), for: .valueChanged)
        
        // TODO: call feed api
    }
    
    deinit {
        refreshControl?.removeTarget(self, action: #selector(SearchViewContoller.refreshingDidChange), for: .valueChanged)
    }
    
    @objc func refreshingDidChange() {
        // TODO: call feed api
        Async.main(after: 2) {
            self.refreshControl?.endRefreshing()
            Async.main(after: 0.5) { UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: self.tableView.reloadData) }
        }
    }
    
}

// MARK: - SearchViewContoller - Private Methods

extension SearchViewContoller {
    
    private func initFeedCellForEstimatedHeight() {
        feedCellForEstimatedHeight = tableView.dequeueReusableCell(FeedCell.self)
        feedCellForEstimatedHeight.frame = view.frame
        feedCellForEstimatedHeight.isHidden = true
        feedCellForEstimatedHeight.forEstimatedHeight = true
        view.addSubview(feedCellForEstimatedHeight)
    }
    
}

// MARK: - SearchViewContoller - UITableView

extension SearchViewContoller {
    
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
