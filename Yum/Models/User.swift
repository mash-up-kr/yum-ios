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
    var id = 1
    var userProfile = "https://images.unsplash.com/photo-1504884790557-80daa3a9e621?auto=format&fit=crop&w=400"
    var userName = "박종훈"
    var feedNum = 2
    var followerNum = 3
    var followingNum = 4
    var userMsg = "Healthy food is my life ♥\nBE MY SELF with healthy life"
    
    init(json: JSON) {
        self.userProfile = json["profileImg"].stringValue
        self.userName = json["nickname"].stringValue
        self.feedNum = json["feedNum"].intValue
        self.followerNum = json["followerNum"].intValue
        self.followingNum = json["followingNum"].intValue
        self.userMsg = json["profileMessage"].stringValue
        self.id = json["id"].intValue
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
