//
//  UserModel.swift
//
//  Created by maaz tausif on 25/09/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class UserModel: Codable {

  enum CodingKeys: String, CodingKey {
    case incompleteResults = "incomplete_results"
    case items
    case totalCount = "total_count"
  }

  var incompleteResults: Bool?
  var items: [Items]?
  var totalCount: Int?

  init (incompleteResults: Bool?, items: [Items]?, totalCount: Int?) {
    self.incompleteResults = incompleteResults
    self.items = items
    self.totalCount = totalCount
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    incompleteResults = try container.decodeIfPresent(Bool.self, forKey: .incompleteResults)
    items = try container.decodeIfPresent([Items].self, forKey: .items)
    totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
  }

}

extension UserModel{
    
    static func getUsersData(search:String,completion: ((UserModel?) -> ())?){
        
    
            let params = [
              "q": search
              
            ] as [String : Any]
               //let verify = AuthRouter.login(parameters: params)
        let verify = UserRouter.User(parameters: params)
               FSRequestHandler.sendRequest(router: verify, progressMsg: "Loading", progressType: ProgressType.progresssHud) { (verifyResponse: UserModel?, error: APIError?) in
    
                   if let error = error {
                       AlertManager.showError(msg: error.errorDescription)
                   } else if let completion = completion, let verifyResponse = verifyResponse {
    
                       completion(verifyResponse)
                   }
    
               }
           }
    
}
