//
//  Article.swift
//  GoodNews
//
//  Created by gaeng on 2022/04/25.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
    
}
