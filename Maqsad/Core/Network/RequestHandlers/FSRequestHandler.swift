//
//  RequestHandler.swift
//  Field Services
//
//  Created by Waqas on 05/09/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import Foundation
import Alamofire

class FSRequestHandler {

    
    static func sendRequest<T>(router:URLRequestConvertible, progressMsg: String?, progressType: ProgressType, mayRefreshToken: Bool = true, completion: ((T?, APIError?) -> ())?) where T : Codable {
        
        FSRequestHandler.showHUD(progressType: progressType, progressMsg: progressMsg)
        API.request(urlRequest: router) { (object: T?, error: APIError?) in
            if error?.ecode == 401 && mayRefreshToken {
                print("Error:",error)
                FSRequestHandler.dismissHUD(progressType: progressType)
            } else {
                FSRequestHandler.dismissHUD(progressType: progressType)
                completion?(object,error)
            }
           
        }
    }
  
    
    static func sendRequestForCollection<T:Codable>(router:URLRequestConvertible, progressMsg: String?, progressType: ProgressType, mayRefreshToken: Bool = true, completion: (([T]?, APIError?) -> ())?) {

        FSRequestHandler.showHUD(progressType: progressType, progressMsg: progressMsg)
        
        API.requestForCollection(urlRequest: router) { (objects:[T]?, error: APIError?) in
            if error?.ecode == 401 && mayRefreshToken {
                FSRequestHandler.dismissHUD(progressType: progressType)
            } else {
                FSRequestHandler.dismissHUD(progressType: progressType)
                completion?(objects,error)
            }
          
        }
    }
    
    static func sendRequestForCollectionOfCollection<T:Codable>(router:URLRequestConvertible, progressMsg: String?, progressType: ProgressType, mayRefreshToken: Bool = true, completion: (([[T]]?, APIError?) -> ())?) {

           FSRequestHandler.showHUD(progressType: progressType, progressMsg: progressMsg)
           
           API.requestForCollectionOfCollection(urlRequest: router) { (objects:[[T]]?, error: APIError?) in
               if error?.ecode == 401 && mayRefreshToken {
                   FSRequestHandler.dismissHUD(progressType: progressType)
               } else {
                   FSRequestHandler.dismissHUD(progressType: progressType)
                   completion?(objects,error)
               }
             
           }
       }

    static func uploadImages<T>(router:URLRequestConvertible, params:APIParams, imagesData:[Data], progressMsg: String?, progressType: ProgressType, completion: ((T?, APIError?) -> ())?) where T : Codable {
        FSRequestHandler.showHUD(progressType: progressType, progressMsg: progressMsg)
        API.uploadImage(urlRequest: router,params: params, imagesData:imagesData) { (object: T?, error: APIError?) in
            if error?.ecode == 401{
                print("Error:",error)
                FSRequestHandler.dismissHUD(progressType: progressType)
            } else {
                FSRequestHandler.dismissHUD(progressType: progressType)
                completion?(object,error)
            }
        }
        
    }
    
    static func uploadOnlyImage<T>(router:URLRequestConvertible, imageData:Data, progressMsg: String?, progressType: ProgressType, completion: ((T?, APIError?) -> ())?) where T : Codable {
        FSRequestHandler.showHUD(progressType: progressType, progressMsg: progressMsg)
       
        
    
        API.uploadImageOnly(urlRequest: router, imagesData:imageData) { (object: T?, error: APIError?) in
            if error?.ecode == 401{
                print("Error:",error)
                FSRequestHandler.dismissHUD(progressType: progressType)
            } else {
                FSRequestHandler.dismissHUD(progressType: progressType)
                completion?(object,error)
            }
        }
        
    }
    
    
    static func showHUD(progressType: ProgressType, progressMsg: String? = nil) {
        if progressType == .progresssHud {
            ProgressHud.showHud(progressMsg: progressMsg)
        }
    }
    
    static func dismissHUD(progressType: ProgressType) {
        if progressType == .progresssHud {
            ProgressHud.hideHud()
        }
    }
}

