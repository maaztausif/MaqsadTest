//
//  APIHelper.swift
//  CropReport
//
//  Created by Aun Wasti on 04/12/2016.
//  Copyright © 2016 Aun Wasti. All rights reserved.
//  Version: 0.2

import Foundation
import Alamofire
import UIKit
/// API to create requests for simple and collection objects
struct API {
  
  static func request<T:Codable>(urlRequest: URLRequestConvertible, completion:  ( (T?,APIError?) -> () )?) {
    
    
        AF.request(urlRequest)
            .responseDecodable { (response: DataResponse<T>) in
                
                var error:APIError?
                if response.response?.statusCode == 401 {
                    error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
                    //NotificationCenter.default.post(name: .logoutUser, object: nil)
                }
                else {
                if response.response?.statusCode != 200 {
                    error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
                }
                }
//                else if let err = response.error {
//                    error =  APIError.parseError(response: response.response, data: response.data, error:  err)
//                }
                completion?(response.result.value, error)
        }
    
    
    
    
  }
  
  static func requestForCollection<T:Codable>(urlRequest: URLRequestConvertible, completion: ( ([T]?,APIError?) -> () )?) {

        AF.request(urlRequest)
            .responseDecodable { (response: DataResponse<[T]>) in
                
                var error:APIError?
                if let code = response.response?.statusCode, code > 300 {
                    error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
                } else if let err = response.error {
                    error =  APIError.parseError(response: response.response, data: response.data, error:  err)
                }
                completion?(response.result.value, error)
        }

  }
    
    static func requestForCollectionOfCollection<T:Codable>(urlRequest: URLRequestConvertible, completion: ( ([[T]]?,APIError?) -> () )?) {

           AF.request(urlRequest)
               .responseDecodable { (response: DataResponse<[[T]]>) in
                   
                   var error:APIError?
                   if let code = response.response?.statusCode, code > 300 {
                       error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
                   } else if let err = response.error {
                       error =  APIError.parseError(response: response.response, data: response.data, error:  err)
                   }
                   completion?(response.result.value, error)
           }

//        .responseJSON(completionHandler: { (response) in
//                debugPrint(response)
//            })
     }
    
    static func uploadImageOnly<T:Codable>(urlRequest: URLRequestConvertible, imagesData:Data, completion: ( (T?,APIError?) -> () )?) {
        AF.upload(multipartFormData: { multipartFormData in
            
//            params.forEach({ (param) in
//                multipartFormData.append((param.value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: param.key)
//            })
            multipartFormData.append(imagesData, withName: "", fileName: "file_\(index)"+".jpg", mimeType: "image/jpeg")
//            for (index,imageData) in imagesData.enumerated() {
//
         //   }
            
           
           
            
        }, with: urlRequest).responseDecodable { (response: DataResponse<T>) in
            
            var error:APIError?
            if let code = response.response?.statusCode, code > 300 {
                error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
            } else if let err = response.error {
                error =  APIError.parseError(response: response.response, data: response.data, error:  err)
            }
            completion?(response.result.value, error)
    }
//           .responseJSON { (res) in
//            var error:APIError?
//            if let code = res.response?.statusCode, code > 300 {
//                error =  APIError.parseError(response: res.response, data: res.data, error:  res.error)
//            } else if let err = res.error {
//                error =  APIError.parseError(response: res.response, data: res.data, error:  err)
//            }
//            completion?(res.result.value, error)
//        }
    }
    
    static func uploadImage<T:Codable>(urlRequest: URLRequestConvertible, params:APIParams, imagesData:[Data], completion: ( (T?,APIError?) -> () )?) {
        AF.upload(multipartFormData: { multipartFormData in
            
            params.forEach({ (param) in
                multipartFormData.append((param.value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: param.key)
            })
            
            for (index,imageData) in imagesData.enumerated() {
                multipartFormData.append(imageData, withName: "", fileName: "file_\(index)"+".jpg", mimeType: "image/jpeg")
            }
            
           
           
            
        }, with: urlRequest).responseDecodable { (response: DataResponse<T>) in
            
            var error:APIError?
            if let code = response.response?.statusCode, code > 300 {
                error =  APIError.parseError(response: response.response, data: response.data, error:  response.error)
            } else if let err = response.error {
                error =  APIError.parseError(response: response.response, data: response.data, error:  err)
            }
            completion?(response.result.value, error)
    }
//           .responseJSON { (res) in
//            var error:APIError?
//            if let code = res.response?.statusCode, code > 300 {
//                error =  APIError.parseError(response: res.response, data: res.data, error:  res.error)
//            } else if let err = res.error {
//                error =  APIError.parseError(response: res.response, data: res.data, error:  err)
//            }
//            completion?(res.result.value, error)
//        }
    }
}



extension Alamofire.DataRequest {
    
    @discardableResult
    func decodable<T: Decodable>(success: @escaping (T) -> Swift.Void, failure: @escaping (Error?) -> Swift.Void) -> Self {
        response(completionHandler: { response in
            if let error = response.error {
                failure(error)
                return
            }
            if let data = response.data {
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    failure(nil)
                    return
                }
                success(result)
            }
        })
        
        return self
    }
}


