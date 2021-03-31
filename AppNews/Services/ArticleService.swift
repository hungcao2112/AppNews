//
//  ArticleService.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import Alamofire
import ObjectMapper

class ArticleService {
    
    public func getArticles(page: Int = 1, pageSize: Int = 50, _ onSuccess: @escaping ([Article]?) -> (), onFailure: ((_ err: Error?) -> ())? = nil) {
        let params: [String: Any] = ["q": "Arsenal", //Just my favorite team
                                     "page": page,
                                     "pageSize": pageSize,
                                     "sortBy": "publishedAt"]
        APIService.shared.request(url: Constants.DOMAIN_URL + "/everything", method: .get, params: params, Article.self) { (datas, error) in
            if let error = error {
                onFailure?(error)
                return
            }
            onSuccess(datas)
        }
    }
}

