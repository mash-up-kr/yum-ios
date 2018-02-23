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

struct Feed: Codable {
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

extension Feed {
    
    static func getFeeds(completed: @escaping ([Feed]) -> Void) {
        Alamofire
            .request("http://192.168.0.57:3003/post/get_feed", method: .get, encoding: URLEncoding.default)
            .log(level: .verbose)
            .responseData { response in
                guard let data = response.result.value, let getFeedsResponse = try? JSONDecoder().decode(GetFeedsResponse.self, from: data) else {
                    completed([])
                    return
                }
                completed(getFeedsResponse.feeds)
            }
    }
    
    struct GetFeedsResponse: Codable {
        
        var feeds: [Feed]
        
        enum CodingKeys: String, CodingKey { // swiftlint:disable:this nesting
            case feeds = "results"
        }
        
    }
    
}

extension Feed {
    
    static func postFeed(feed: Feed, imageData: Data, completed: @escaping (Bool) -> Void) {
        guard let userId = "rldndud123@a.com".data(using: .utf8), let content = feed.body.data(using: .utf8), let calorie = String(feed.calorie).data(using: .utf8) else {
            completed(false)
            return
        }
        let hashtags = NSKeyedArchiver.archivedData(withRootObject: feed.tags)
        
        let multipartFormData = { (multipartFormData: MultipartFormData) -> Void in
//            multipartFormData.append(imageUrl, withName: "postImg")
            multipartFormData.append(imageData, withName: "postImg")
            multipartFormData.append(userId, withName: "userId")
            multipartFormData.append(content, withName: "content")
            multipartFormData.append(calorie, withName: "calorie")
            multipartFormData.append(hashtags, withName: "hashtags")
        }
        Alamofire.upload(multipartFormData: multipartFormData, to: "http://192.168.0.57:3003/post/upload", method: .post) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    
                    guard response.result.isSuccess else {
                        completed(false)
                        return
                    }
                    completed(true)
                }
            case .failure:
                completed(false)
            }
        }
    }

}
