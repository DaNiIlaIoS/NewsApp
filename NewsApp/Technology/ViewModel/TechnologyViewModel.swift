//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 23.06.2024.
//

import Foundation

final class TechnologyViewModel: NewsListViewModel {
    override func loadData(searchText: String? = nil) {
        super.loadData(searchText: searchText)
        APIManager.getNews(theme: .technology, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
