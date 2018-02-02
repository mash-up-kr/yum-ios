//
//  SearchResultViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

final class SearchResultViewController: UITableViewController {
    
    var startCalorie: Int!
    var endCalorie: Int!
    var tag: String?
    var userName: String?
    
    private var feedCellForEstimatedHeight: FeedCell!
    
    private var feeds: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFeedCellForEstimatedHeight()
        refreshControl?.addTarget(self, action: #selector(SearchResultViewController.refreshingDidChange), for: .valueChanged)
        loadFeeds()
    }
    
    deinit {
        refreshControl?.removeTarget(self, action: #selector(SearchResultViewController.refreshingDidChange), for: .valueChanged)
    }
    
    @objc func refreshingDidChange() {
        loadFeeds()
    }
    
    @IBAction func backBtnClicked() {
        self.navigationController?.dismiss(animated: true)
    }
}

// MARK: - SearchResultViewController - Private Methods

extension SearchResultViewController {
    
    private func initFeedCellForEstimatedHeight() {
        feedCellForEstimatedHeight = tableView.dequeueReusableCell(FeedCell.self)
        feedCellForEstimatedHeight.frame = view.frame
        feedCellForEstimatedHeight.isHidden = true
        feedCellForEstimatedHeight.forEstimatedHeight = true
        view.addSubview(feedCellForEstimatedHeight)
    }
    
    private func loadFeeds() {
        //        refreshControl?.beginRefreshing()
        //        Feed.getFeeds { feeds in
        //            self.feeds = feeds
        //            self.refreshControl?.endRefreshing()
        //            Async.main(after: 0.5) { UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: self.tableView.reloadData) }
        //        }
        refreshControl?.beginRefreshing()
        ServerClient.search(startCalorie: startCalorie,
                            endCalorie: endCalorie,
                            tag: tag,
                            userName: userName) { feeds in
            Async.main(after: 1) {
                self.feeds = feeds
                self.refreshControl?.endRefreshing()
                Async.main(after: 0.5) { UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: self.tableView.reloadData) }
            }
        }
    }
    
}

// MARK: - SearchResultViewController - UITableView

extension SearchResultViewController {
    
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
