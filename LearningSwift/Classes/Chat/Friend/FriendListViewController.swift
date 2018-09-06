//
//  FriendListViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/5.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit


class FriendListViewController: BaseViewController {

    private let kCellIdentifier: String = "FriendListCellIdentifier"
    var items = [FriendModel]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendListTableCell.self, forCellReuseIdentifier: kCellIdentifier)
        return tableView;
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        self.title = "好友列表"
        
        self.configUI()
        self.getOnlineData()
        
    }
    
    func configUI() {
        
        view.addSubview(tableView);
        
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func getOnlineData() {
            NetworkHelper.loadFriendsList { (responseArr) in
                
                self.items = responseArr
                self.tableView.reloadData()
            }
        }
}


extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! FriendListTableCell
        let friendModel: FriendModel = items[indexPath.row]
        cell.configureWithItem(friendModel.user!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


