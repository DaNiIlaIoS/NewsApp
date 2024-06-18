//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 17.06.2024.
//

import Foundation

protocol TableCollectionViewProtocol {}

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewProtocol]
}
