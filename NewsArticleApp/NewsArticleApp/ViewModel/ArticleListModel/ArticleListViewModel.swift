//
//  ArticleListViewModel.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

import Alamofire

class ArticleListViewModel {

    let articlesList: Bindable<[ArticleList]?> = Bindable(nil)
    var showLoader: Bindable<Bool> = Bindable(false)

    func getArticleList() {
        self.showLoader.value = true
        AF.request(Server.articleApi, method: .get).response { response in
            switch(response.result) {
            case .success(let data):
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(ArticleResponseData.self, from: postData)
                        DispatchQueue.main.async {
                            log.verbose(decodedData.articles ?? "")
                            self.showLoader.value = false
                            self.articlesList.value = decodedData.articles ?? []
                        }
                    } else {
                        self.showLoader.value = false
                        log.verbose("Data is Empty")
                    }
                } catch {
                    self.showLoader.value = false
                    log.verbose("Error getting Data")
                }
            case .failure(let error):
                self.showLoader.value = false
                log.verbose("Error getting Data: \(error)")
                
            }
        }
    }
}
