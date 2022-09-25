//
//  ProgressHud.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

import Foundation
import MBProgressHUD
import PKHUD
import UIKit

struct ProgressHud {

    static let progressHudTag = 5545
    static func getLastVc()->UIViewController?{
        var navigationController:UINavigationController?
        if #available(iOS 15.0, *) {
            navigationController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController as? UINavigationController
        }else{
            navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
        }
        let lastViewController = navigationController?.viewControllers.last
        return lastViewController
    }
    static func showHud(progressMsg: String? = nil, completion: (() -> Void)? = nil)  {
//        HUD.show(.progress)
        let vc = getLastVc()
//        vc?.view.setTemplateWithSubviews(vc?.loading ?? false)
        
    }
    
    
    static func showHud(onView view:UIView, progressMsg: String? = nil)  {
        HUD.show(.progress)
    }
    
   
    static func hideHud(onView view:UIView?) {
        HUD.hide()
    }
    
    static func hideHud()  {
//        HUD.hide()
        let vc = getLastVc()
        vc?.loading = false
//        vc?.view.setTemplateWithSubviews(vc?.loading ?? false)
    }
}

