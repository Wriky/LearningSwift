//
//  ChatTableViewDataSource.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
import UIKit

struct TableViewItem {
    let title : String
    let subTitle : String
    
}

extension ChatTableCell {
    func configureWithItem(_ item : TableViewItem) {
        self.textLabel?.text = item.title
        self.detailTextLabel?.text = item.subTitle
    }
}

class ChatTableViewDataSource: NSObject, UITableViewDataSource {
    fileprivate var items = [TableViewItem]()
    
    func addItem(_ item: TableViewItem){
        items.append(item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ChatTableCell
        cell.configureWithItem(items[indexPath.row])
        return cell
        
    }
    

}
