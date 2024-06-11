//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 11.06.2024.
//

import Foundation

protocol NewsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var imageData: Data? { get }
}

final class NewsViewModel: NewsViewModelProtocol {
    var title: String
    var description: String
    var date: String
    var imageData: Data?
    
    init(article: ArticleCellViewModel) {
        title = article.title
        description = article.description
        date = article.publishedAt
        imageData = article.imageData
    }
}
