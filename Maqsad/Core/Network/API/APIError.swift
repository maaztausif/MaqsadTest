//
//  APIError.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

import Foundation
import FirebaseFirestore

/// This is responsible of creating custom errors. Its serverError dictionary should be build according to service requirements


protocol F3ErrorProtocol: LocalizedError {
    
    var ecode: Int { get }
}

struct APIError: F3ErrorProtocol {
    
    var ecode: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(description: String, code: Int) {
        self._description = description
        self.ecode = code
    }
    
    
    static func parseError(response:HTTPURLResponse?, data:Data?, error:Error?) -> APIError {
        
        // creating instance of API error
        var apiError:APIError = APIError(description: error?.localizedDescription ?? "", code: response?.statusCode ?? 0) //= APIError.unKnown(error?.localizedDescription ?? APIConstant.ErrorMsg.unknown)
        
        if(response == nil)
        {
            // No Internet Connection and timeout error
            if let notInternetError = error as NSError?, notInternetError.domain == NSURLErrorDomain && notInternetError.code == NSURLErrorNotConnectedToInternet {
                apiError = APIError(description: APIConstant.ErrorMsg.noInternet, code: NSURLErrorNotConnectedToInternet)
            }
        }
        else if(error == nil) {
            
            // unauthorised
            //            if (response!.statusCode == 401)
            //            {
            //                apiError = APIError.unAuthorized(APIConstant.ErrorMsg.unauthorized)
            //            }
            //                // server specific error
            //            else
            //            {
            // parsing server data
            if let errorData = data {
                
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: errorData, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                    
                    
                    var messageFromServer = ""
                    var statusCode = response?.statusCode
                    if(dictionary.keys.contains(APIConstant.ErrorKey.code) || dictionary.keys.contains(APIConstant.ErrorKey.message))
                    {
                        //                            if let code = dictionary[APIConstant.ErrorKey.code] as? Int {
                        //                                customError.errorCode = String(code)
                        //                            }
                        if let message = dictionary[APIConstant.ErrorKey.message] as? [String]{
                            if let msg = message.first {
                                messageFromServer = msg
                            } else {
                                messageFromServer = "Server Error"
                            }
                        }
                    } else {
                        messageFromServer = (dictionary["Message"] as? String) ?? ""
                        //Handling our 365 server limitation
                        if messageFromServer == "Unauthorized" {
                            statusCode = 401
                        }
                        
                    }
                    apiError = APIError(description: messageFromServer, code: statusCode ?? 0)
                }
                catch {
                    apiError = APIError(description: APIConstant.ErrorMsg.serialization, code: response?.statusCode ?? 0)
                    sendLog(res:response, err: apiError._description)
                }
            }
            //            }
        } else if let response = response, response.statusCode > 300 {
            if let errorData = data {
                
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: errorData, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                    
                    
                    var messageFromServer = ""
                    if(dictionary.keys.contains(APIConstant.ErrorKey.code) || dictionary.keys.contains(APIConstant.ErrorKey.message))
                    {
                        //                            if let code = dictionary[APIConstant.ErrorKey.code] as? Int {
                        //                                customError.errorCode = String(code)
                        //                            }
                        if let message = dictionary[APIConstant.ErrorKey.message] as? [String]{
                            if let msg = message.first {
                                messageFromServer = msg
                            }
                        }
                    }
                    apiError = APIError(description: messageFromServer, code: response.statusCode)
                }
                catch {
                    apiError = APIError(description: APIConstant.ErrorMsg.serialization, code: response.statusCode)
                    self.sendLog(res: response, err: "A data serialization error occured.")
                }
            }
        }
        
        return apiError
    }
    static func sendLog(res:HTTPURLResponse?,err:String){
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        db.collection("serializationError").document("\(Date())").setData([
            "Date":Date(),
            "API Crash URL":"\(res?.url?.absoluteString ?? "")" ,
            "Error":err, "Status Code":(res?.statusCode ?? 0),
            "Date in Long":Date().timeIntervalSince1970])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
//        ref = db.collection("serializationError").document("\(Date())").setData(["Date":Date(),"API Crash URL":"\(res?.url?.absoluteString ?? "")" , "Error":err, "Status Code":(res?.statusCode ?? 0),"Date in Long":Date().timeIntervalSince1970]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
    }
}
//
//enum APIError:Error {
//    case noInternet(String)
//    case timeOut(String)
//    case unAuthorized(String)
//    case serverError(String)
//    case serialization(String)
//    case unKnown(String)
//    case validation(String)
//}
//
//extension APIError: LocalizedError {
//
//    var errorDescription: String? {
//        switch self {
//        case .noInternet(let localizedError), .timeOut(let localizedError), .unAuthorized(let localizedError), .serverError(let localizedError), .serialization(let localizedError), .unKnown(let localizedError), .validation(let localizedError):
//            return NSLocalizedString(localizedError,comment: "")
//        }
//    }
//
//    var ecode:Int? {
//        switch self {
//        case .noInternet:
//            return NSURLErrorNotConnectedToInternet
//        case .serverError:
//            return 500
//        default:
//            return 0
//        }
//    }
//
//    static func parseError(response:HTTPURLResponse?, data:Data?, error:Error?) -> APIError {
//
//        // creating instance of API error
//        var apiError = APIError.unKnown(error?.localizedDescription ?? APIConstant.ErrorMsg.unknown)
//
//        if(response == nil)
//        {
//            // No Internet Connection and timeout error
//            if let notInternetError = error as NSError?, notInternetError.domain == NSURLErrorDomain && notInternetError.code == NSURLErrorNotConnectedToInternet {
//                apiError = APIError.noInternet(APIConstant.ErrorMsg.noInternet)
//            }
//        }
//        else if(error == nil) {
//
//            // unauthorised
//            //            if (response!.statusCode == 401)
//            //            {
//            //                apiError = APIError.unAuthorized(APIConstant.ErrorMsg.unauthorized)
//            //            }
//            //                // server specific error
//            //            else
//            //            {
//            // parsing server data
//            if let errorData = data {
//
//                do {
//                    let dictionary = try JSONSerialization.jsonObject(with: errorData, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
//
//
//                    var messageFromServer = ""
//                    if(dictionary.keys.contains(APIConstant.ErrorKey.code) || dictionary.keys.contains(APIConstant.ErrorKey.message))
//                    {
//                        //                            if let code = dictionary[APIConstant.ErrorKey.code] as? Int {
//                        //                                customError.errorCode = String(code)
//                        //                            }
//                        if let message = dictionary[APIConstant.ErrorKey.message] as? [String]{
//                            if let msg = message.first {
//                                messageFromServer = msg
//                            } else {
//                                messageFromServer = "Server Error"
//                            }
//                        }
//                    }
//                    apiError = APIError.serverError(messageFromServer)
//                }
//                catch {
//                    apiError = APIError.serialization(APIConstant.ErrorMsg.serialization)
//                }
//            }
//            //            }
//        } else if let response = response, response.statusCode > 300 {
//            if let errorData = data {
//
//                do {
//                    let dictionary = try JSONSerialization.jsonObject(with: errorData, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
//
//
//                    var messageFromServer = ""
//                    if(dictionary.keys.contains(APIConstant.ErrorKey.code) || dictionary.keys.contains(APIConstant.ErrorKey.message))
//                    {
//                        //                            if let code = dictionary[APIConstant.ErrorKey.code] as? Int {
//                        //                                customError.errorCode = String(code)
//                        //                            }
//                        if let message = dictionary[APIConstant.ErrorKey.message] as? [String]{
//                            if let msg = message.first {
//                                messageFromServer = msg
//                            }
//                        }
//                    }
//                    apiError = APIError.serverError(messageFromServer)
//                }
//                catch {
//                    apiError = APIError.serialization(APIConstant.ErrorMsg.serialization)
//                }
//            }
//        }
//
//        return apiError
//    }
//
//}
