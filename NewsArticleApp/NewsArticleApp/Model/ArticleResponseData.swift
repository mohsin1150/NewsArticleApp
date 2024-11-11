//
//  ArticleResponseData.swift
//  NewsArticleApp
//
//  Created by Mohammad Mohsin on 10/11/24.
//

struct ArticleResponseData: Codable {
    let articles: [ArticleList]?
}

// MARK: - SupportList
class ArticleList: Codable {
    var author: String?
    let title, description: String?
    let url, urlToImage: String?
    var content: String?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case content
        case publishedAt
    }
    
    init(author: String?,
         title: String?,
         description: String?,
         url: String?,
         urlToImage: String?,
         content: String?,
         publishedAt: String?
    ) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.content = content
        self.publishedAt = publishedAt
    }
}
