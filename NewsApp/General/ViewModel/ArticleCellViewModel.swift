//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 10.06.2024.
//

import Foundation

final class ArticleCellViewModel: TableCollectionViewProtocol {
    let title: String
    let description: String
    let urlToImage: String
    var publishedAt: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description ?? ""
        publishedAt = article.publishedAt
        urlToImage = article.urlToImage ?? ""
        
        if let formateDate = formateDate(dateString: self.publishedAt) {
            self.publishedAt = formateDate
        }
    }
    
    private func formateDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
//        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}
