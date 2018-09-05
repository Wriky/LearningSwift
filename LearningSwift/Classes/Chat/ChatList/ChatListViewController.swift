//
//  ChatListViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

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
