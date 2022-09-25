//
//  APIConstant.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

import Foundation

struct APIConstant {
    
    struct Validations {
        static let statusCode = 200..<300
        static let contentType = "application/json"
    }
  
 
    
    struct ErrorMsg {
        static let noInternet = "Internet could not be reached."
        static let timeout = "Server time out occurred."
        static let unauthorized = "You are not authorized to use this app."
        static let serialization = "Some error occurred. Please contact your system administrator."
        static let unknown = "Any unKnown error occurred"
        static let validation = "One or more fields are missing"
        static let parse = "Could not parse server response."
        static let refreshToken = "Can't able to refresh token."
    }
    
    
    
    struct ErrorKey {
        static let code = "ErrorCode"
        static let message = "ErrorMessage"
    }
    
    struct ErrorCode {
        static let Deleted = 501
    }
    
    // MARK: - URL Paths
    
    struct URL {
        static var base:String {
            get{
                switch appType{
                case .Dev:
                   return "https://api.github.com/"  //Dev
                case .Demo:
                    return  "http://13.82.68.160:6080/api/" //Demo Enviroment
                case .QA:
                    return  "http://13.82.68.160:6080/api/" //QA Enviroment
                case .Production:
                    return  "http://13.82.68.160:6080/api/" //Production Enviroment
                }
            }
        }
        

//     static let base = "http://13.82.68.160:6080/api/" //Demo Enviroment
       
    }
    
    struct URLPath {
        
        static let user = "search/users"
        
        
        
        
//        static let userCarAddCar = "Garage/UserCarAddCar"
    }
    
    struct Settings {
        static let PageLimit = 20
    }
    
    
    
    struct Debug {
        struct User {
//            static let username = "aliawan@hudasoft.com"
            static let username = "zshaikh@ibizi.com" //aliawan@hudasoft.com
            static let password = "TechSys3#"
//            static let password = "TechSys3#"
          //  static let username = "aliawan@hudasoft.com"
       
          //  static let password = "TechSys3#"
//            static let email = "ammar@hudasoft.com"
            static let email = "zshaikh@ibizi.com"
            static let carId = "1"
        
        }
    }

    
}

