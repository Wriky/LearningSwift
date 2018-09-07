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
        self.loadOnlineData()
        self.loadCoreData()
    }
    
    func configUI() {
        
        view.addSubview(tableView);
        
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func loadOnlineData() {
        NetworkHelper.loadFriendsList { (responseArr) in
            
            self.items = responseArr
            self.tableView.reloadData()
        }
    }
    
    func loadCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
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


