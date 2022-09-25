//
//  AlertManager.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//

import Foundation
import LKAlertController

struct AlertManager {


    static func show(msg:String) {
        Alert(title: "", message: msg)
            .addAction("Ok").show()
    }
    
    static func showError(msg:String?) {
        Alert(title: "Error", message: msg)
            .addAction("Ok").show()
    }
    
    
    static func showError(msg:String, completion: (() -> Void)?) {
        
        Alert(title: "Error", message: msg)
            .addAction("Ok", style: .default, handler: { _ in
                if let completion = completion {
                    completion()
                }
            }).show()
    }
    
    static func showMsg(title:String, msg:String, completion: (() -> Void)?) {
     
        Alert(title: title, message: msg)
            .addAction("Ok", style: .default, handler: { _ in
                if let completion = completion {
                    completion()
                }
            }).show()
    }
    
    
    static func showWarning(msg:String, completion: (() -> Void)?) {
        
        Alert(title: "Warning", message: msg)
            .addAction("Cancel")
            .addAction("Ok", style: .default, handler: { _ in
                if let completion = completion {
                    completion()
                }
            }).show()
    }
    
    static func showAlertWithTextField(title:String, msg:String, placeholder:String, completion: ((String?) -> Void)?) {
        var textField = UITextField()
        textField.placeholder = placeholder
        
        Alert(title:title, message: msg)
            .addAction("Cancel")
            .addTextField(&textField).addAction("Ok", style: .default, handler: { _ in
            if let completion = completion {
                completion(textField.text)
            }
        }).show()
    }
    
    static func showAlert(title:String, msg:String, ok: (() -> Void)?) {
        

        Alert(title: title, message: msg)
            .addAction("Cancel")
            .addAction("Ok", style: .default, handler: { _ in
                if let ok = ok {
                    ok()
                }
            }).show()
    }
}
