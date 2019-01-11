//
//  FriendListViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/9/5.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import CoreData



class FriendListViewController: BaseViewController {

    private let kCellIdentifier: String = "FriendListCellIdentifier"
    var items: [NSManagedObject] = []
    
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
        self.loadCoreData()
//        self.loadOnlineData()
    }
    
    func configUI() {
        
        view.addSubview(tableView);
        
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func loadOnlineData() {
        ChatViewModel.requestFriendList(success: { (response) in
            
            
        }) { (error) in
            
        }
    }
    
    func loadCoreData() {
        let managedObjectContext = NSManagedObjectContext.mr_default()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreUser")
        
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                self.items = results
                self.tableView.reloadData()
                print("fetchResult: \(results)")
            }
        } catch {
            fatalError("获取失败")
        }
    }
}


extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! FriendListTableCell
        let userModel = items[indexPath.row]
        cell.configureWithItem(userModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


