//
//  Feed.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 5..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Feed {
    var feedId: Int
    var userProfileImageUrl: String
    var userName: String
    var foodImageUrl: String
    var body: String
    var calorie: Int
    var tags: [String] = []
    var isLike: Bool = false
    
    init(json: JSON) {
        self.feedId = json["feedId"].intValue
        self.userProfileImageUrl = json["profileImg"].stringValue
        self.userName = json["nickname"].stringValue
        self.foodImageUrl = json["imgUrl"].stringValue
        self.body = json["content"].stringValue
        self.calorie = json["calorie"].intValue
        self.tags.append(contentsOf: json["hashtags"].stringValue.components(separatedBy: ","))
    }
    
    init(feedId: Int,
         userProfileImageUrl: String,
         userName: String,
         foodImageUrl: String,
         body: String,
         calorie: Int,
         tags: [String]) {
        self.feedId = feedId
        self.userProfileImageUrl = userProfileImageUrl
        self.userName = userName
        self.foodImageUrl = foodImageUrl
        self.body = body
        self.calorie = calorie
        self.tags = tags
    }
}