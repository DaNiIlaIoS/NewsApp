//
//  NewsResponceObject.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

struct NewsResponseObject {
    let totalResult: Int
    var article: [NewsResponseObject]
}
