//
//  BaseRequestHandler.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//


import Foundation
import UIKit

class BaseRequestHandler: RequestHandlerProtocol {
  
  var progressIndicator: ProgressType = .progresssHud
  
  
  /// This request is for getting object
  ///
  /// - Parameters:
  ///   - requestType: Type of request must be made in concrete classes
  ///   - parameters: parameters list
  ///   - completion: response from server
    func sendRequest<T: ResponseObjectSerializable>(requestType: Int, parameters: Any? = nil, progressMsg: String? = nil, progressType:ProgressType = .progresssHud, completion: ((T?, APIError?) -> ())?)             {
        progressIndicator = progressType
    // must be override from concrete classes
    self.requestDidStart(progressMsg: progressMsg)
  }
  
  
  /// This request is for getting collection objects
  ///
  /// - Parameters:
  ///   - requestType: Type of request must be made in concrete classes
  ///   - parameters: parameters list
  ///   - completion: response from server
  func sendRequestForCollection<T: ResponseCollectionSerializable>(requestType: Int, parameters: Any? = nil, progressMsg: String? = nil, progressType:ProgressType = .progresssHud, completion: (([T]?, APIError?) -> ())?) {
    // must be override from concrete classes
    progressIndicator = progressType
    self.requestDidStart(progressMsg: progressMsg)
  }
  
  func requestDidStart(progressMsg: String? = nil) {
    showHUD(progressMsg: progressMsg)
    // NotificationCenter.default.post(name: Notification.Name(NotificationName.requestStart), object: nil)
    
  }
  func requestDidFinish() {
    self.dismissHUD()
    // NotificationCenter.default.post(name: Notification.Name(NotificationName.requestEnd), object: nil)
  }
}

// MARK: ProgressHUDProtocol implementations
extension BaseRequestHandler: ProgressableHUD {
  
  func showHUD(progressMsg: String? = nil) {
    if self.progressIndicator == .progresssHud {
        ProgressHud.showHud()
    }
  }
  
  func dismissHUD() {
    if self.progressIndicator == .progresssHud {
        ProgressHud.hideHud()
    }
  }
}
