//
//  ChatDetailViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

struct MessageTableItem {
    let nameStr: String
    let timeStr: String
    let contentStr: String
}

class ChatDetailViewController: BaseViewController {
    var nameStr: String = ""
    private let kCellIdentifier: String = "ChatDetailCellIdentifier"
    var items = [MessageTableItem]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(ChatDetailTableCell.self, forCellReuseIdentifier: kCellIdentifier)
        return tableView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = nameStr
        
        view.addSubview(tableView);
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        let array = ["Eggs", "Milk", "Vegetables"]
        let contentArray = ["香蜜沉沉烬如霜很好看", "今天天气不错", "沁园春.雪❄️"]
        
        for (index, value) in array.enumerated() {
            items.append(MessageTableItem(nameStr: value, timeStr: "2018-08-08", contentStr: contentArray[index]))
        }
        self.tableView.reloadData()
    }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ChatDetailTableCell
        cell.configureWithItem(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
