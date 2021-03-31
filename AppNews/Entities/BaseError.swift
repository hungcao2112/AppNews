//
//  BaseError.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import Alamofire
import ObjectMapper

enum ApiErrorType: Error {
    case networkNotConnected
    case dataNotFound
    case requestError
    
    var localizedDescription: String {
        switch self {
        case .networkNotConnected:
            return "Check your Internet connection and try again"
        case .dataNotFound:
            return "Data not found. Please try again"
        case .requestError:
            return "An error occured. Please try again"
        }
    }
}

class BaseError: Mappable, Error {
    
    var status: String?
    var code: String?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
}
