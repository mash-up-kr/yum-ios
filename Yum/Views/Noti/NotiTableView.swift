//
//  NotiTableView.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class NotiTableView: UITableView {
    let CELL_NAME = "NotiTableViewCell"
    var notis: [Noti] = []
    
    func initiate() {
        ServerClient.getNotiList(page: 0) { notis, error in
            guard let notis = notis else {
                CrashUtil.process(error)
                return
            }
            
            DispatchQueue.main.async {
                self.notis = notis
                self.register(UINib(nibName: self.CELL_NAME, bundle: nil), forCellReuseIdentifier: self.CELL_NAME)
                self.dataSource = self
                self.reloadData()
            }
        }
    }
}

extension NotiTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NAME, for: indexPath) as? NotiTableViewCell else {
            return UITableViewCell()
        }
        
        let noti = notis[indexPath.row]
        
        cell.profileImage.imageUrl = noti.userProfile
        cell.nameLabel.text = noti.userName
        
        return cell
    }
}
