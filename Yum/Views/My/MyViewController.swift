//
//  MyViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 1. 19..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    var userName: String = ServerClient.userName // ViewController Parameter
    var user: User!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var feedNumLabel: UILabel!
    @IBOutlet weak var followerNumLabel: UILabel!
    @IBOutlet weak var followingNumLabel: UILabel!
    @IBOutlet weak var userMsgLabel: UILabel!
    @IBOutlet weak var collectionView: MyCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userName
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        ServerClient.getUserDetail(userName: self.userName) { user in
            guard let user = user else {
                return
            }
            
            self.user = user
            
            DispatchQueue.main.async {
                self.profileImage.setImageUrl(user.userProfile)
                self.feedNumLabel.text = String(user.feedNum)
                self.followerNumLabel.text = String(user.followerNum)
                self.followingNumLabel.text = String(user.followingNum)
                self.userMsgLabel.text = user.userMsg
            }
        }
        
        ServerClient.getUserFeedList(page: 0, userName: self.userName) { feeds in
            DispatchQueue.main.async {
                self.collectionView.initiate(feeds, self)
            }
        }
    }
    
    @IBAction func followingBtnClicked() {
        
    }
}
