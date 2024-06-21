//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 21.06.2024.
//

import Foundation

protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData()
}

class NewsListViewModel: NewsListViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    var page = 0
    
    // MARK: - Methods
    func loadData() {
        page += 1
    }
    
    func handleResult(_ result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let article):
            self.convertToCellViewModel(articles: article)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    private func loadImage() {
        for (i, section) in sections.enumerated() {
            
            for (index, item) in section.items.enumerated() {
                
                if let article = item as? ArticleCellViewModel {
                    
                    APIManager.getImageData(url: article.urlToImage) { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                                
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func convertToCellViewModel(articles: [ArticleResponseObject]) {
        let viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels
        }
    }
}
