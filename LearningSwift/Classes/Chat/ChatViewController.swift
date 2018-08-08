//
//  ChatViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    let dataSource = ChatTableViewDataSource()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self;
        tableView.register(ChatTableCell.self, forCellReuseIdentifier: "cellIdentifier")
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
        
        for title in array {
            self.addItem(title, subTitle: "sb"+title)
        }
        self.tableView.reloadData()
    }
    
    func addItem(_ title: String, subTitle: String) {
        self.dataSource.addItem(TableViewItem(title: title, subTitle: subTitle))
    }
}

extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
