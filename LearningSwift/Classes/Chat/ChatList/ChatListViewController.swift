//
//  ChatListViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import CoreData

class ChatListViewController: BaseViewController {
    let dataSource = ChatListTableViewDataSource()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self;
        tableView.register(ChatListTableCell.self, forCellReuseIdentifier: dataSource.kChatListCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.addRightNavBarButton()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        self.loadFriendListData()
    }
    
    func addRightNavBarButton() {
        
        let buttonItem = UIBarButtonItem.init(title: "好友列表", style: .done, target: self, action: #selector(jumpToFriendListInterface))
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    func loadFriendListData() {
        NetworkHelper.loadFriendsList { (responseArr) in
            
            for friendModel: FriendModel in responseArr {
                let channelCode = friendModel.channel?.code
                
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.client?.subscribeClient(channelCode!)
                
            }
            self.dataSource.items = responseArr
            self.tableView.reloadData()
            
        }
    }
    
    @objc func jumpToFriendListInterface() {
        let vc = FriendListViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveUserInfo(_ userModel: UserModel ) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        user.setValue(userModel.nick_name, forKey: "nick_name")
        user.setValue(userModel.mobile, forKey: "mobile")
        user.setValue(userModel.id, forKey: "id")
        user.setValue(userModel.gender, forKey: "gender")

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("无法保存")
        }
    }
    
    func saveFriendInfo(_ friendModel: FriendModel) {
        
    }
}

extension ChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: FriendModel = dataSource.items[indexPath.row]
        let vc = ChatDetailViewController()
        vc.itemModel = item
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
