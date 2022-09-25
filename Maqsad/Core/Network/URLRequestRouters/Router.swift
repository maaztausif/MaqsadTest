//
//  Router.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

/// This is responsible of creating custom errors. Its serverError dictionary should be build according to service requirements

import Foundation
import Alamofire

typealias APIParams = Parameters
typealias APIHeaders = HTTPHeaders
typealias APIMehtod = HTTPMethod

typealias APIParamsEncoding  = ParameterEncoding

typealias APIJSONEncoding = JSONEncoding
typealias APIURLEncoding = URLEncoding

/// This should be implemented by all concrete routers
protocol Routable: URLRequestConvertible {
  
  /// baseURL for calling any server
  var baseURLString: String { get }
  
  /// by default method is HTTPMethod.get
  var method: APIMehtod { get }
  
  /// path should be appended with baseURL
  var path: String { get }
  var parameterEncoding: APIParamsEncoding { get }
  var headers: APIHeaders { get }
  
  func asURLRequest() throws -> URLRequest
}

extension Routable {
  var method: APIMehtod { return APIMehtod.get }
  var parameterEncoding: APIParamsEncoding { return APIJSONEncoding.default }
  var headers: APIHeaders { return ["Content-Type":"application/json"] }
  var baseURLString: String { return APIConstant.URL.base }
}
