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
    let dataSourceSelf = ChatListTableViewDataSource()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSourceSelf
        tableView.delegate = self
        tableView.register(ChatListTableCell.self, forCellReuseIdentifier: dataSourceSelf.kChatListCellIdentifier)
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
                
                self.saveFriendInfo(friendModel)
//                self.saveUserInfo(friendModel.user!)
            }
            self.dataSourceSelf.items = responseArr
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
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext)
        let friend: CoreFriend = NSManagedObject(entity: entity!, insertInto: managedObjectContext) as! CoreFriend
        friend.setValue(friendModel.ID, forKey: "id")
        friend.setValue(friendModel.state, forKey: "state")
        friend.setValue(friendModel.target_id, forKey: "target_id")
        
        let channelEntity = NSEntityDescription.entity(forEntityName: "Channel", in: managedObjectContext)
        let channel: CoreChannel = NSManagedObject(entity: channelEntity!, insertInto: managedObjectContext) as! CoreChannel
        channel.setValue(friendModel.channel?.resource_id, forKey: "resource_id")
        channel.setValue(friendModel.channel?.code, forKey: "code")
        channel.setValue(friendModel.channel?.resource_type, forKey: "resource_type")
        friend.channel = channel
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        let user: CoreUser = NSManagedObject(entity: userEntity!, insertInto: managedObjectContext) as! CoreUser
        user.setValue(friendModel.user?.id, forKey: "id")
        user.setValue(friendModel.user?.nick_name, forKey: "nick_name")
        user.setValue(friendModel.user?.mobile, forKey: "mobile")
        user.setValue(friendModel.user?.gender, forKey: "gender")
        friend.user = user
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("无法保存")
        }
    }
}

extension ChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: FriendModel = dataSourceSelf.items[indexPath.row]
        let vc = ChatDetailViewController()
        vc.itemModel = item
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            dataSourceSelf.removeAtIndex(indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
}
