//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 09.06.2024.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var numberOfCells: Int {
        articles.count
    }
    
    private var articles: [ArticleResponseObject] = [] {
        didSet {
            reloadData?()
        }
    }
    
    // MARK: - Initialization
    init() {
        loadData()
    }
    
    // MARK: - Methods
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        return ArticleCellViewModel(article: article)
    }
    
    // MARK: - Private Methods
    private func loadData() {
        // TODO: LoadData
        setupMockObjects()
    }
    
    private func setupMockObjects() {
        articles = [ArticleResponseObject(title: "First title",
                                          description: "First object description in the mock object",
                                          urlToImage: "...", publishedAt: "12.04.2017"),
                    ArticleResponseObject(title: "Second title",
                                          description: "Second object description in the mock object",
                                          urlToImage: "...",
                                          publishedAt: "12.04.2017"),
                    ArticleResponseObject(title: "Third title",
                                          description: "Third object description in the mock object",
                                          urlToImage: "...",
                                          publishedAt: "12.04.2017"),
                    ArticleResponseObject(title: "Fourth title",
                                          description: "Fourth object description in the mock object",
                                          urlToImage: "...",
                                          publishedAt: "12.04.2017"),
                    ArticleResponseObject(title: "Fifth title",
                                          description: "Fifth object description in the mock object",
                                          urlToImage: "...",
                                          publishedAt: "12.04.2017")]
    }
}
