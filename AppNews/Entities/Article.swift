//
//  Article.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

class Article: Object, Mappable {
    
    @objc dynamic var newsTitle: String?
    @objc dynamic var newsDescription: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var sourceUrl: String?
    @objc dynamic var publishedAt: Date?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        newsTitle <- map["title"]
        newsDescription <- map["description"]
        imageUrl <- map["urlToImage"]
        sourceUrl <- map["url"]
        publishedAt <- (map["publishedAt"], ISO8601DateTransform())
    }
}


