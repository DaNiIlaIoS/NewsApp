//
//  ArticleResponseObject.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

struct ArticleResponseObject: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let publishedAt: String
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case urlToImage
        case publishedAt
    }
}
