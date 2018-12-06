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
            
            for friendEntity: FriendModel in responseArr {
                let channelCode = friendEntity.channel?.code

                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.client?.subscribeClient(channelCode!)

                self.saveFriendInfo(friendEntity)
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
    
    func saveFriendInfo(_ friendModel: FriendModel) {
        let managedObjectContext = NSManagedObjectContext.mr_default()
        let friendEntity: CoreFriend = CoreFriend.mr_createEntity(in: managedObjectContext)!
        friendEntity.id = friendModel.ID
        friendEntity.state = friendModel.state
        friendEntity.target_id = friendModel.target_id
        
        let channelEntity: CoreChannel = CoreChannel.mr_createEntity(in: managedObjectContext)!
        channelEntity.resource_id = friendModel.channel?.resource_id
        channelEntity.resource_type = friendModel.channel?.resource_type
        channelEntity.code = friendModel.channel?.code
        friendEntity.channel = channelEntity
        
        let userEntity: CoreUser = CoreUser.mr_createEntity(in: managedObjectContext)!
        userEntity.id = friendModel.user?.id
        userEntity.nick_name = friendModel.user?.nick_name
        userEntity.mobile = friendModel.user?.mobile
        userEntity.gender = Int16((friendModel.user?.gender)!)
        friendEntity.user = userEntity
        
        managedObjectContext.mr_saveToPersistentStoreAndWait()
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
