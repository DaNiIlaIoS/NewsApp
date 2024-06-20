//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    var numberOfCells: Int { get }
    var showError: ((String) -> Void)? { get set }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    
    var showError: ((String) -> Void)?
    var numberOfCells: Int {
        articles.count
    }
    
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    // MARK: - Initialization
    init() {
        loadData()
    }
    
    // MARK: - Methods
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    // MARK: - Private Methods
    private func loadData() {
        print(#function)
        APIManager.getNews(theme: .general, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        // TODO: get image
//        guard let url = URL(string: articles[row].urlToImage),
//              let data = try? Data(contentsOf: url)else { return }
        print(#function)
        for (index, article) in articles.enumerated() {
            APIManager.getImageData(url: article.urlToImage) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObjects() {
        articles = [ArticleCellViewModel(article: ArticleResponseObject(title: "First title",
                                                                        description: "First object description in the mock object",
                                                                        urlToImage: "...", publishedAt: "12.04.2017"))]
    }
}
