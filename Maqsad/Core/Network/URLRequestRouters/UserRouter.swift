//
//  UserRouter.swift
//  Maqsad
//
//  Created by maaz tausif on 25/09/2022.
//


import Foundation

enum UserRouter: Routable {

    case User(parameters: APIParams)

   
    
    // MARK: Method
    var method: APIMehtod {
        switch self {
        case .User:
            return .get
        }
        
    }
    
    var parameterEncoding: APIParamsEncoding {
        
        switch self {
        case .User:
            return APIURLEncoding.default
        }

    }
    
    // MARK: Paths
    var path: String {
        switch self {
        case .User:
            return APIConstant.URLPath.user
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        // creating URL
        let url = try self.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting up method
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.dictionary
        
        // setting parameters and encoding
        switch self {
        case .User(let parameters):
            
            let encoding = parameterEncoding
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
