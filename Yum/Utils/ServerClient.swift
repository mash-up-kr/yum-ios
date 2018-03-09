//
//  ServerClient.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServerClient {
    // TODO add error parameter

    static let HOST = "http://52.78.80.125:3003"

    static var userToken: String?
    static var userName = "김현섭"
    static var user: User!
    static var userId: Int = -1

    static func request(_ url: String, _ method: HTTPMethod, _ parameters: Parameters, callback: ((JSON?) -> Void)? = nil) {
        Alamofire.request(url, method: method, parameters: parameters).response { response in
            guard let data = response.data else {
                print(String(describing: response.request))
                print(String(describing: response.response))
                print(String(describing: response.data))
                print(String(describing: response.error))
                callback?(nil)
                return
            }

            let json = JSON(data)
//            print("\(method) - \(url)")
//            print(parameters)
//            print(json)
            callback?(json)
        }
    }

    static func login(facebookId: String,
                      name: String,
                      callback: ((Bool) -> Void)? = nil) {
        let url = HOST + "/auth/facebook"
        let method: HTTPMethod = HTTPMethod.post
        let parameters: Parameters = [
            "facebookUserNickname": name,
            "facebookCode": facebookId
        ]

        request(url, method, parameters) { json in
            guard let json = json else {
                callback?(false)
                return
            }

            if json["result"].exists() {
                userId = json["result"].arrayValue.first!["id"].intValue
                callback?(true)
            } else {
                callback?(false)
            }
        }
    }

    static func getFeedList(callback: (([Feed]) -> Void)? = nil) {
        let url = HOST + "/feed"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json in
            guard let json = json else {
                callback?([Feed]())
                return
            }

            if json["results"].exists() {
                callback?(json["results"]["feedData"].arrayValue.map({ Feed(json: $0) }))
            } else {
                callback?([Feed]())
            }
        }
    }

    static func getFeedDetail(feedId: Int,
                              callback: ((Feed) -> Void)? = nil) {

    }

    static func writeFeed(content: String,
                          calorie: Int,
                          tags: [String],
                          image: UIImage,
                          callback: ((Feed?) -> Void)? = nil) {
        let url = HOST + "/feed"
        let imgData = UIImageJPEGRepresentation(image, 1)!

        Alamofire.upload(
                multipartFormData: { MultipartFormData in
                    MultipartFormData.append("\(ServerClient.userId)".data(using: .utf8)!, withName: "userId")
                    MultipartFormData.append(content.data(using: .utf8)!, withName: "content")
                    MultipartFormData.append("\(calorie)".data(using: .utf8)!, withName: "calorie")
                    MultipartFormData.append("아보카토".data(using: .utf8)!, withName: "hashtags")
                    MultipartFormData.append(imgData, withName: "postImg", fileName: "image.jpeg", mimeType: "image/jpeg")
                },
                to: url,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response { response in
                            print(String(describing: response.request))
                            print(String(describing: response.response))
                            print(String(describing: response.data))
                            print(String(describing: response.error))
                            print(JSON(response.data!))
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                    getFeedList { feeds in
                        callback?(feeds.filter({ $0.body == content && $0.calorie == calorie }).first)
                    }
                }
        )
    }

    static func modifyFeed(feedId: Int,
                           content: String,
                           calorie: Int,
                           tags: [String],
                           imgUrl: String,
                           callback: ((Feed) -> Void)? = nil) {

    }

    static func deleteFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {

    }

    static func isLikeFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json in
            guard let json = json else {
                return
            }

            if json["code"].intValue == 1 {
                callback?(json["isLike"].boolValue)
            }
        }
    }

    static func likeFeed(feedId: Int,
                         callback: ((Bool) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.post
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json in
            callback?(true)
        }
    }

    static func unlikeFeed(feedId: Int,
                           callback: ((Bool) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.delete
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json in
            callback?(true)
        }
    }

    static func toggleFeedLike(feedId: Int,
                               callback: ((Bool) -> Void)? = nil) {
        isLikeFeed(feedId: feedId) { isLike in
            if isLike {
                unlikeFeed(feedId: feedId) { success in
                    callback?(success)
                }
            } else {
                likeFeed(feedId: feedId) { success in
                    callback?(success)
                }
            }
        }
    }

    static func search(startCalorie: Int,
                       endCalorie: Int,
                       tag: String?,
                       userName: String?,
                       callback: (([Feed]) -> Void)? = nil) {
        let url = HOST + "/search"
        let method: HTTPMethod = HTTPMethod.get
        var parameters: Parameters = [
            "userId": ServerClient.userId,
            "startCalorie": startCalorie,
            "endCalorie": endCalorie
        ]

        if let userName = userName {
            parameters["nickname"] = userName
        }

        request(url, method, parameters) { json in
            guard let json = json else {
                callback?([Feed]())
                return
            }

            if json["results"].exists() {
                callback?(json["results"]["feedData"].arrayValue.map({ Feed(json: $0) }))
            } else {
                callback?([Feed]())
            }
        }
    }

    static func getUserDetail(userName: String,
                              callback: ((User?) -> Void)? = nil) {
        let url = HOST + "/user/\(ServerClient.userId)"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [:]

        request(url, method, parameters) { json in
            guard let json = json else {
                callback?(nil)
                return
            }

            if json["result"].exists() {
                callback?(User(json: json["result"].arrayValue.first!))
            } else {
                callback?(nil)
            }
        }
    }

    static func getUserFeedList(page: Int,
                                userName: String,
                                callback: (([Feed]) -> Void)? = nil) {
        let url = HOST + "/user/\(ServerClient.userId)/feeds"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [:]

        request(url, method, parameters) { json in
            guard let json = json else {
                callback?([Feed]())
                return
            }

            if json["result"].exists() {
                callback?(json["result"].arrayValue.map({ Feed(json: $0) }))
            } else {
                callback?([Feed]())
            }
        }
    }

    static func getNotiList(page: Int,
                            callback: (([Noti]) -> Void)? = nil) {

    }
}
