//
//  User.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var userProfile = "https://images.unsplash.com/photo-1504884790557-80daa3a9e621?auto=format&fit=crop&w=400"
    var userName = "박종훈"
    var feedNum = 2
    var followerNum = 3
    var followingNum = 4
    var userMsg = "Healthy food is my life ♥\nBE MY SELF with healthy life"
    
    init(json: JSON) {
        self.userProfile = json["user_profile"].stringValue
        self.userName = json["user_name"].stringValue
        self.feedNum = json["feed_num"].intValue
        self.followerNum = json["follower_num"].intValue
        self.followingNum = json["following_num"].intValue
        self.userMsg = json["user_msg"].stringValue
    }
    
    init(userProfile: String,
         userName: String,
         feedNum: Int,
         followerNum: Int,
         followingNum: Int,
         userMsg: String) {
        self.userProfile = userProfile
        self.userName = userName
        self.feedNum = feedNum
        self.followerNum = followerNum
        self.followingNum = followingNum
        self.userMsg = userMsg
    }
}
