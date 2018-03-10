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
import Toaster

class ServerClient {
    static let HOST = "http://52.78.80.125:3003"

    static var userToken: String?
    static var userName = "김현섭"
    static var user: User!
    static var userId: Int = -1

    static func request(_ url: String, _ method: HTTPMethod, _ parameters: Parameters, callback: ((JSON, Error?) -> Void)? = nil) {
        Alamofire.request(url, method: method, parameters: parameters).response { response in
            if let error = response.error {
                callback?(JSON(), error)
                return
            }

            guard let data = response.data else {
                callback?(JSON(), ServerError("There is no data"))
                return
            }

            let json = JSON(data)

//            print("\(method) - \(url)")
//            print(parameters)
//            print(json)

            callback?(json, nil)
        }
    }

    static func login(facebookId: String,
                      name: String,
                      callback: ((Error?) -> Void)? = nil) {
        let url = HOST + "/auth/facebook"
        let method: HTTPMethod = HTTPMethod.post
        let parameters: Parameters = [
            "facebookUserNickname": name,
            "facebookCode": facebookId
        ]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(error)
                return
            }

            if json["result"].exists() {
                userId = json["result"].arrayValue.first!["id"].intValue
                callback?(nil)
            } else {
                callback?(ServerError(json))
            }
        }
    }

    static func getFeedList(callback: (([Feed]?, Error?) -> Void)? = nil) {
        let url = HOST + "/feed"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(nil, error)
                return
            }

            if json["results"].exists() {
                callback?(json["results"]["feedData"].arrayValue.map({ Feed(json: $0) }), nil)
            } else {
                callback?(nil, ServerError(json))
            }
        }
    }

    static func getFeedDetail(feedId: Int,
                              callback: ((Feed?, Error?) -> Void)? = nil) {

    }

    static func writeFeed(content: String,
                          calorie: Int,
                          tags: [String],
                          image: UIImage,
                          callback: ((Error?) -> Void)? = nil) {
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
                        callback?(nil)
                    case .failure(let encodingError):
                        callback?(encodingError)
                    }
                }
        )
    }

    static func modifyFeed(feedId: Int,
                           content: String,
                           calorie: Int,
                           tags: [String],
                           imgUrl: String,
                           callback: ((Error?) -> Void)? = nil) {

    }

    static func deleteFeed(feedId: Int,
                           callback: ((Error?) -> Void)? = nil) {

    }

    static func isLikeFeed(feedId: Int,
                           callback: ((Bool?, Error?) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(nil, error)
                return
            }

            if json["code"].intValue == 1 {
                callback?(json["isLike"].boolValue, nil)
            } else {
                callback?(nil, ServerError(json))
            }
        }
    }

    static func likeFeed(feedId: Int,
                         callback: ((Error?) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.post
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(error)
                return
            }

            callback?(nil)
        }
    }

    static func unlikeFeed(feedId: Int,
                           callback: ((Error?) -> Void)? = nil) {
        let url = HOST + "/feed/like/\(feedId)"
        let method: HTTPMethod = HTTPMethod.delete
        let parameters: Parameters = [
            "userId": ServerClient.userId
        ]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(error)
                return
            }

            callback?(nil)
        }
    }

    static func toggleFeedLike(feedId: Int,
                               callback: ((Error?) -> Void)? = nil) {
        isLikeFeed(feedId: feedId) { isLike, error in
            guard let isLike = isLike else {
                CrashUtil.process(error)
                return
            }

            if isLike {
                unlikeFeed(feedId: feedId) { error in
                    if let error = error {
                        callback?(error)
                    } else {
                        callback?(nil)
                    }
                }
            } else {
                likeFeed(feedId: feedId) { error in
                    if let error = error {
                        callback?(error)
                    } else {
                        callback?(nil)
                    }
                }
            }
        }
    }

    static func search(startCalorie: Int,
                       endCalorie: Int,
                       tag: String?,
                       userName: String?,
                       callback: (([Feed]?, Error?) -> Void)? = nil) {
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

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(nil, error)
                return
            }

            if json["results"].exists() {
                callback?(json["results"]["feedData"].arrayValue.map({ Feed(json: $0) }), nil)
            } else {
                callback?(nil, ServerError(json))
            }
        }
    }

    static func getUserDetail(userName: String,
                              callback: ((User?, Error?) -> Void)? = nil) {
        let url = HOST + "/user/\(ServerClient.userId)"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [:]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(nil, error)
                return
            }

            if json["result"].exists() {
                callback?(User(json: json["result"].arrayValue.first!), nil)
            } else {
                callback?(nil, ServerError(json))
            }
        }
    }

    static func getUserFeedList(page: Int,
                                userName: String,
                                callback: (([Feed]?, Error?) -> Void)? = nil) {
        let url = HOST + "/user/\(ServerClient.userId)/feeds"
        let method: HTTPMethod = HTTPMethod.get
        let parameters: Parameters = [:]

        request(url, method, parameters) { json, error in
            if let error = error {
                callback?(nil, error)
                return
            }

            if json["result"].exists() {
                callback?(json["result"].arrayValue.map({ Feed(json: $0) }), nil)
            } else {
                callback?(nil, ServerError(json))
            }
        }
    }

    static func getNotiList(page: Int,
                            callback: (([Noti]?, Error?) -> Void)? = nil) {

    }
}

struct ServerError: Error {
    let msg: String

    init(_ msg: String) {
        self.msg = msg
    }

    init(_ json: JSON) {
        self.init(String(describing: json))
    }
}
