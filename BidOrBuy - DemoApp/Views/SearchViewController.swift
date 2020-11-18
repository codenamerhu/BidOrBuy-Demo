//
//  ViewController.swift
//  BidOrBuy - DemoApp
//
//  Created by Rhulani Ndhlovu on 2020/11/14.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searcBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = BidOrBuyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.isHidden = true
        
        print("mode \(viewModel.items)")
        self.tableView.delegate = viewModel
        self.tableView?.dataSource = viewModel
        
        //self.tableView
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        
    }
    
    
    
    func pushData(image: String, title: String){
        
        
    }
    
    
    
}
