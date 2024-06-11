//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 10.06.2024.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let publishedAt: String
    let urlToImage: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        publishedAt = article.publishedAt
        urlToImage = article.urlToImage
    }
}
