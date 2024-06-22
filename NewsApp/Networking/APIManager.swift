//
//  APIManager.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 10.06.2024.
//

import Foundation

enum Theme: String {
    case general = "general"
    case business = "business"
    case technology = "technology"
}

final class APIManager {
    private static let apiKey = "e30d6cfafc85469eb6f14e2f35443c88"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines"
    
    // MARK: - Create url path and make request
    static func getNews(theme: Theme,
                        page: Int,
                        searchText: String?,
                        completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        var searchParameter = ""
        if let searchText = searchText {
            searchParameter = "&q=\(searchText)"
        }
        let stringUrl = baseUrl + path + "?category=\(theme.rawValue)&language=en&page=\(page)" + searchParameter + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
    // MARK: - Handle Response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
            
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                completion(.success(model.articles))
                
            } catch let decodeError {
                completion(.failure(decodeError))
            }
            
        } else {
            completion(.failure(NetworkingError.unknownError))
        }
    }
}
