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
    static var userName = "김현섭"
    static var user: User!
    
    static func login(facebookId: String,
                      callback: ((Bool) -> Void)? = nil) {
        ServerClient.userToken = facebookId
        callback?(true)
        
        ServerClient.getUserDetail(userName: userName) { user in
            ServerClient.user = user
        }
    }

    static func register(facebookId: String,
                         userName: String,
                         callback: ((Bool) -> Void)? = nil) {
        ServerClient.userToken = facebookId
        callback?(true)
        
        ServerClient.getUserDetail(userName: userName) { user in
            ServerClient.user = user
        }
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
            userProfileImageUrl: ServerClient.user.userProfile,
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
            userProfileImageUrl: ServerClient.user.userProfile,
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
    
    static func getUserDetail(userName: String,
                              callback: ((User) -> Void)? = nil) {
        if let user = DummyDatabase.users.filter({ $0.userName == userName }).first {
            callback?(user)
        }
    }
    
    static func getUserFeedList(userName: String,
                                callback: (([Feed]) -> Void)? = nil) {
        callback?(DummyDatabase.feeds.filter({ $0.userName == userName }))
    }
}
