//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    // MARK: - Private Methods
    override func loadData() {
        super.loadData()
        
        APIManager.getNews(theme: .general, page: page) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
