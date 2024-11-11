//
//  AlertService.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import Moya

enum AlertService {
    case getAlertList
}

extension AlertService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://mocki.io/")!
    }

    var path: String {
        switch self {
        case .getAlertList:
            return "v1/e91eafa6-46f7-4bd1-87f7-2770c7b7e194"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAlertList:
            return .get
        }
    }

    var sampleData: Data {
        let json = ""
        return json.data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["": ""]
    }
}

