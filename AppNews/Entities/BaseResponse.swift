//
//  BaseResponse.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Mappable {
    var status: String?
    var totalResults: Int = 0
    var articles: [T]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["articles"]
        totalResults <- map["totalResults"]
        articles <- map["articles"]
    }
}

