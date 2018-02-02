//
//  MyCollectionView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class MyCollectionView: UICollectionView {
    let CELL_NAME = "MyCollectionViewCell"
    var feeds: [Feed]!
    
    func initiate(_ feeds: [Feed]) {
        self.feeds = feeds
        self.register(UINib(nibName: CELL_NAME, bundle: nil), forCellWithReuseIdentifier: CELL_NAME)
        self.delegate = self
        self.dataSource = self
    }
}

extension MyCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//        if(indexPath.row >= self.items.count) { return }
//
//        delegate?.infiniteTableView?(self, didSelectItemAt: indexPath, item: items[indexPath.row], cell: cell)
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(self.frame.width / 3)
        return CGSize(width: width, height: width)
    }
}

extension MyCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_NAME, for: indexPath)
        
        if let cell = cell as? MyCollectionViewCell {
            let feed = feeds[indexPath.row]
            cell.image.setImageUrl(feed.foodImageUrl)
        }
        
        return cell
    }
}
