//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 11.06.2024.
//

import Foundation

protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var articles: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    
    private(set) var articles: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    // MARK: - Initialization
//    init() {
//        loadData()
//    }
    
    // MARK: - Methods
    func loadData() {
        APIManager.getNews(theme: .business) { [weak self] result in
            guard let self = self else { return }
            
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
    }
    
    private func loadImage() {
        for (i, section) in articles.enumerated() {
            
            for (index, item) in section.items.enumerated() {
                
                if let article = item as? ArticleCellViewModel {
                    
                    APIManager.getImageData(url: article.urlToImage) { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.articles[i].items[index] as? ArticleCellViewModel {
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
    
    private func convertToCellViewModel(articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
        let secondSection = TableCollectionViewSection(items: viewModels)
        self.articles = [firstSection, secondSection]
    }
}


