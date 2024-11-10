//
//  NewsArticleApi.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import Alamofire
import Moya

class LocoNavApi {

    static let usersService = MoyaProvider<UsersService>(
        session: DefaultAlamofireManager.sharedManager,
        plugins: MoyaHelper.shared.getPlugins()
    )

    static func getHeaders() -> [String: String] {
        var headers = ["": ""]
        return headers
    }
}

class DefaultAlamofireManager: Alamofire.Session {

    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 120 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy

        return DefaultAlamofireManager(configuration: configuration)
    }()
}

