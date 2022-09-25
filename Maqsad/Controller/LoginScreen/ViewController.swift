//
//  ViewController.swift
//  Maqsad
//
//  Created by maaz tausif on 25/09/2022.
//

import UIKit

class ViewController: UIViewController {

    var items:[Items]?
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnSearchClicked(_ sender: Any) {
        getSearchData(search: txtSearch.text ?? "")
    }
    func getSearchData(search:String){
        UserModel.getUsersData(search: search) { res in
            self.items = res?.items
            if self.items?.count == 0 {
                showAlert(inViewController: self, title: "Alert!", message: "No data exist")
            }
            if let _items = self.items{
                let vc = UserDetailVC.instantiate(type: .main) as! UserDetailVC
                vc.viewModel.items = _items
                self.navigationController?.push(vc: vc)
            }
            
        }
    }

}

