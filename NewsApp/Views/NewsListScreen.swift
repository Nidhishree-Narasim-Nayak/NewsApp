//
//  NewsListScreen.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import SwiftUI

struct NewsListScreen: View {
    
    @StateObject private var newsArticleListViewModel = NewsArticleListViewModel()
    
    var body: some View {
        
        NavigationView {
        
        List(newsArticleListViewModel.newsArticles, id: \.id) { newsArticle in
            NavigationLink(destination: Text("Foo")) {
                NewsArticleCell(newsArticle: newsArticle)
            }
        }
        .listStyle(.plain)
        .onAppear {
            newsArticleListViewModel.getNews()
        }
        .navigationTitle("Top Headlines")
        }
    }
}

struct NewsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsListScreen()
    }
}

struct NewsArticleCell: View {
    
    let newsArticle: NewsArticleViewModel 
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: newsArticle.urlToImage) { image in
                image.resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            
            VStack {
                Text(newsArticle.title)
                    .fontWeight(.bold)
                Text(newsArticle.description)
            }
        }
    }
}
