//
//  UserDetailVC.swift
//  Maqsad
//
//  Created by maaz tausif on 25/09/2022.
//

import UIKit


class UserDetailVC: UIViewController {
    var viewModel = UserVM()
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI(){
        viewModel.sortedItems = viewModel.items.sorted(by: {$0.login ?? "" < $1.login ?? ""})
        setDelegate()
    }
    func setDelegate(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UserDetailTVC.nib, forCellReuseIdentifier: UserDetailTVC.identifire)
    }
}
extension UserDetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.sortedItems.count > viewModel.pagination{
            return viewModel.pagination
        }else{
            return viewModel.sortedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: UserDetailTVC.identifire) as! UserDetailTVC
        cell.configure(items: viewModel.sortedItems[indexPath.row])
        return cell
    }
    
    //MARK: Pagination
    ///https://api.github.com/search/users?q=foo&page=9 //Didn't working
    ///this pagination didn't working so I use my own pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height )){
                if viewModel.isLoading == false{
                    viewModel.isLoading = true
                }else{
                    if viewModel.pagination >= viewModel.sortedItems.count{
                        viewModel.pagination = viewModel.sortedItems.count
                    }else{
                        viewModel.pagination = viewModel.pagination + 9
                        tblView.reloadData()
                    }
                }
            }
        }
    
}
