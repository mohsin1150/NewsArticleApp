//
//  MoyaHelper.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import UIKit
import Moya
import SwiftyJSON

class MoyaHelper {

    public static let shared = MoyaHelper()

    private init() {}

    func getPlugins() -> [PluginType] {
        var plugins: [PluginType] = []
        let config = NetworkLoggerPlugin.Configuration(
            formatter: .init(responseData: jsonResponseDataFormatter),
            logOptions: [.formatRequestAscURL, .verbose]
        )
        plugins.append(NetworkLoggerPlugin(configuration: config))
        return plugins
    }

    // MARK: Private
    private func jsonResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }

    func getErrorMessage(response: Response?) -> String {
        guard let response = response else {
            return ""
        }
        if response.response?.statusCode != 422 {
            return ""
        }
        let json = JSON(response.data)
        var serverErrorMessage = json["message"].stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if json["message"].exists() {
            let errorMessages = json["message"]
            var errorMessage = ""
            for (_, value) in errorMessages {
                errorMessage += value.arrayValue.map({ (errorJson) -> String in
                    errorJson.stringValue
                }).joined(separator: "\n")
            }
            if !errorMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                serverErrorMessage = errorMessage
            }
        }
        return serverErrorMessage
    }

    func getBlockErrorMessage(response: Response?) -> String {
        guard let response = response else {
            return ""
        }
        let json = JSON(response.data)
        var serverErrorMessage = json["error"].stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if json["error"].exists() {
            let errorMessages = json["error"]
            var errorMessage = ""
            for (_, value) in errorMessages {
                errorMessage += value.arrayValue.map({ (errorJson) -> String in
                    errorJson.stringValue
                }).joined(separator: "\n")
            }
            if !errorMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                serverErrorMessage = errorMessage
            }
        }
        return serverErrorMessage
    }
}
