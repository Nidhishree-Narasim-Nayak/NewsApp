//
//  NewsSource.swift
//  NewsApp
//
//  Created by Nidhishree Nayak on 15/07/25.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
