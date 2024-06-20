//
//  NewsResponceObject.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    var articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
