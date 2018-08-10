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
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        let array = ["Eggs", "Milk", "Vegetables"]
        let contentArray = ["香蜜沉沉烬如霜很好看", "今天天气不错", "沁园春.雪❄️"]
        
        for (index, value) in array.enumerated() {
            
            self.addItem(value, subTitle: contentArray[index])
        }
        self.tableView.reloadData()
    }
    
    func addItem(_ title: String, subTitle: String) {
        self.dataSource.addItem(TableViewItem(title: title, subTitle: subTitle))
    }
}

extension ChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: TableViewItem = dataSource.items[indexPath.row]
        let vc = ChatDetailViewController()
        vc.nameStr = item.title
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
