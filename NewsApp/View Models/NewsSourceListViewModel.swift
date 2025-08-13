//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by Nidhishree Nayak on 15/07/25.
//

import Foundation

class NewsSourceListViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSourceViewModel] = []
    
    func getSources() async {
        do {
            let newsSources = try await Webservice().fetchSources(url: Constants.Urls.sources)
            DispatchQueue.main.async {
                self.newsSources = newsSources.map(NewsSourceViewModel.init)
            }
        } catch {
            print(error)
        }
    }
    
}

struct NewsSourceViewModel {
    
    fileprivate var newsSource: NewsSource
    
    var id: String {
        newsSource.id
    }
    
    var name: String {
        newsSource.name
    }
    
    var description: String {
        newsSource.description
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
