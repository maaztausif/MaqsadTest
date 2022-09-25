//
//  CommonFunction.swift
//  Maqsad
//
//  Created by maaz tausif on 26/09/2022.
//

import Foundation
import UIKit
func showAlert( inViewController: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    inViewController.present(alert, animated: true, completion: nil)
}
