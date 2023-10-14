//
//  ApiRouter.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getFeatured
    case getTimeline(page: Int)

    func asURLRequest() throws -> URLRequest {
        let base = try NetworkConstant.baseUrl.asURL()
        let urlAppend = base.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? ""
        
        var urlRequest = URLRequest(url: URL(string: urlAppend)!)
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        if let parameters = parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }

    
    //MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getFeatured:
            return .get
        case .getTimeline:
            return .get
        }
    }
    //MARK: - Path
    private var path: String {
        switch self {
        case .getFeatured:
            return "/featured"
        case .getTimeline:
            return "/timeline"
        }
    }
    
    //MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getFeatured:
            return nil
        case .getTimeline(let page):
            return ["page": page]  // "page" sorgu parametresini ekledik
        default:
            return nil
        }
    }
}
