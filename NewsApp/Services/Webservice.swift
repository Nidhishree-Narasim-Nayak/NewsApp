//
//  Webservice.swift
//  NewsApp
//
//  Created by Nidhishree Nayak on 15/07/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidData
    case decodingError
}

class Webservice {
    
    /// Method to fetch all the news sources, async because marks this function to run in the background
    /// - Parameter url: url
    /// - Returns: array of news sources
    func fetchSources(url: URL?) async throws  -> [NewsSource] {
        guard let url = url else {
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
        return newsSourceResponse?.sources ?? []
    }
    
    
    // Nobody outside this class can call it
    private func fetchNews(by sourceId: String, url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsArticleResponse = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            completion(.success(newsArticleResponse?.articles ?? []))
            
        }.resume()
        
    }
    
    func fetchNewsAsync(sourceId: String, url: URL?) async throws -> [NewsArticle] {
        // allows us to throw or fire an error also
        try await withCheckedThrowingContinuation { continuation in
            fetchNews(by: sourceId, url: url) { result in
                switch result {
                case .success(let newsArticles):
                    continuation.resume(returning: newsArticles)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
