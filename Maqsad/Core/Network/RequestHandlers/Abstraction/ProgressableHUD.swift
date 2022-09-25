//
//  ProgressableHUD.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//
import Foundation

enum ProgressType: Int {
  case progresssHud
  case none
}

/// Should be implemented by all childs supporting HUD functionality
protocol ProgressableHUD {
  
  func showHUD(progressMsg: String?)
  func dismissHUD()
}
