//
//  RequestHandler.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

import Foundation
import UIKit

/// This is a Mediator between ViewController and API. Should be implemented by all request handlers
protocol RequestHandlerProtocol {
  
  /// Optional Method
  ///

  
  func requestDidStart(progressMsg: String?)
  func requestDidFinish()
}

extension RequestHandlerProtocol {
  
  
}
