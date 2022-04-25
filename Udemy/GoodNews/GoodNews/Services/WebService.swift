//
//  WebService.swift
//  GoodNews
//
//  Created by gaeng on 2022/04/25.
//

import Foundation

class WebService {
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                // decode
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                // 알아서 
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
            }
        }.resume()
    }
}
