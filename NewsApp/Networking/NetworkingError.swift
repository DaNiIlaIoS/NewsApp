//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Даниил Сивожелезов on 10.06.2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknownError
}
