//
//  TableViewDataSource.swift
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

extension UITableViewCell {
    func configureWithItem(_ item : TableViewItem) {
        self.textLabel?.text = item.title
        self.detailTextLabel?.text = item.subTitle
    }
}

class TableViewDataSource: NSObject, UITableViewDataSource {
    fileprivate var items = [TableViewItem]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.configureWithItem(items[indexPath.row])
        return cell
        
    }
    

}
