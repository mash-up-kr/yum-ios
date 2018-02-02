//
//  ServerClient.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import Foundation

class ServerClient {
    static var userToken: String?
    static var userProfile = "https://images.unsplash.com/photo-1504884790557-80daa3a9e621?auto=format&fit=crop&w=400"
    static var userName = "박종훈"
    static var feedNum = 2
    static var followerNum = 3
    static var followingNum = 4
    static var userMsg = "Healthy food is my life ♥\nBE MY SELF with healthy life"
    
    static func login(facebookId: String,
                      callback: ((Bool) -> Void)? = nil) {
        ServerClient.userToken = facebookId
        callback?(true)
    }

    static func register(facebookId: String,
                         userName: String,
                         callback: ((Bool) -> Void)? = nil) {
        ServerClient.userToken = facebookId
        callback?(true)
    }

    static func userNameCheck(userName: String,
                              callback: ((Bool) -> Void)? = nil) {
        callback?(true)
    }

    static func getFeedList(page: Int,
                            callback: (([Feed]) -> Void)? = nil) {
        callback?(DummyDatabase.feeds)
    }
    
    static func getFeedDetail(feedId: Int,
                              callback: ((Feed) -> Void)? = nil) {
        if let feed = DummyDatabase.feeds.filter({ $0.feedId == feedId }).first {
            callback?(feed)
        }
    }
    
    static func writeFeed(content: String,
                          calorie: Int,
                          tags: [String],
                          imgUrl: String,
                          callback: ((Feed) -> Void)? = nil) {
        let feed = Feed(
            feedId: Int(Date().timeIntervalSince1970), //current millisecond
            userProfileImageUrl: ServerClient.userProfile,
            userName: ServerClient.userName,
            foodImageUrl: imgUrl,
            body: content,
            calorie: calorie,
            tags: tags
        )
        
        DummyDatabase.feeds.insert(feed, at: 0)
        callback?(feed)
    }
    
    static func modifyFeed(feedId: Int,
                           content: String,
                           calorie: Int,
                           tags: [String],
                           imgUrl: String,
                           callback: ((Feed) -> Void)? = nil) {
        let feed = Feed(
            feedId: feedId,
            userProfileImageUrl: ServerClient.userProfile,
            userName: ServerClient.userName,
            foodImageUrl: imgUrl,
            body: content,
            calorie: calorie,
            tags: tags
        )
        
        DummyDatabase.feeds = DummyDatabase.feeds.map({
            if $0.feedId != feedId {
                return $0
            } else {
                return feed
            }
        })
        
        callback?(feed)
    }
    
    static func deleteFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {
        DummyDatabase.feeds = DummyDatabase.feeds.filter({ $0.feedId != feedId })
        callback?(true)
    }
    
    static func isLikeFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {
        if let feed = DummyDatabase.feeds.filter({ $0.feedId == feedId }).first {
            callback?(feed.isLike)
        }
    }
    
    static func likeFeed(feedId: Int,
                         callback: ((Bool) -> Void)? = nil) {
        if var feed = DummyDatabase.feeds.filter({ $0.feedId == feedId }).first {
            feed.isLike = true
            callback?(true)
        } else {
            callback?(false)
        }
    }
    
    static func unlikeFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {
        if var feed = DummyDatabase.feeds.filter({ $0.feedId == feedId }).first {
            feed.isLike = false
            callback?(true)
        } else {
            callback?(false)
        }
    }
    
    static func search(startCalorie: Int,
                       endCalorie: Int,
                       tag: String?,
                       userName: String?,
                       callback: (([Feed]) -> Void)? = nil) {
        callback?(DummyDatabase.feeds.filter({
            let matchCalorie = (startCalorie <= $0.calorie) && ($0.calorie <= endCalorie)
            
            var matchTag = true
            if let tag = tag {
                matchTag = $0.tags.contains(tag)
            }
            
            var matchUserName = true
            if let userName = userName {
                matchUserName = $0.userName == userName
            }
            
            return matchCalorie && matchTag && matchUserName
        }))
    }
    
    static func getUserFeedList(userName: String,
                                callback: (([Feed]) -> Void)? = nil) {
        callback?(DummyDatabase.feeds.filter({ $0.userName == userName }))
    }
}
