//
//  Article.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import ObjectMapper

class Article: Mappable {
    
    var title: String?
    var description: String?
    var imageUrl: String?
    var sourceUrl: String?
    var publishedAt: Date?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        imageUrl <- map["urlToImage"]
        sourceUrl <- map["url"]
        publishedAt <- (map["publishedAt"], ISO8601DateTransform())
    }
}


