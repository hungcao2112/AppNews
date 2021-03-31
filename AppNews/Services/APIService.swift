//
//  APIService.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import Foundation
import Alamofire
import ObjectMapper

class APIService {
    
    public static var shared = APIService()
    
    private var session: Session!
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        
        session = Session(configuration: configuration)
    }
    
    private func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func request<T: Mappable>(url: String, method: HTTPMethod, params: [String: Any] = [:],_ returnType: T.Type, completion: @escaping (_ result: [T]?, _ error: Error?) -> Void) {
        if !isConnectedToInternet() {
            completion(nil, ApiErrorType.networkNotConnected)
            return
        }
        var defaultParams = params
        defaultParams["apiKey"] = ["f8c3c1452cd44c00a00d8906313861e3"]
        session.request(url, method: method, parameters: defaultParams).responseJSON(completionHandler: { response in

            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    guard let castingValue = response.value as? [String: Any] else { return }
                    guard let mappedData = Mapper<BaseResponse<T>>().map(JSON: castingValue) else { return }
                    
                    guard mappedData.status == "ok" else {
                        completion(nil, ApiErrorType.requestError)
                        return
                    }
                    
                    completion(mappedData.articles, nil)
                } else {
                    completion(nil, ApiErrorType.requestError)
                }
                break
                
            case .failure(let error):
                completion(nil, error)
                break
            }
        })
    }
}
