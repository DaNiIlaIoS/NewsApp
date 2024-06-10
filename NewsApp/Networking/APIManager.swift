//
//  APIManager.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 10.06.2024.
//

import Foundation

final class APIManager {
    private static let apiKey = "e30d6cfafc85469eb6f14e2f35443c88"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "everything"
    
    // MARK: - Create url path and make request
    static func getNews(completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        let stringUrl = baseUrl + path + "?sources=bbc-news&language=en" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data, error: error, completion: completion)
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
