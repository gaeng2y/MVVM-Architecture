//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by gaeng on 2022/04/25.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSections(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    private let artilce: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.artilce = article
    }
}

extension ArticleViewModel {
    var title: String {
        return self.artilce.title
    }
    var description: String {
        return self.artilce.description
    }
}
