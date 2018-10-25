//
//  ChatListTableViewDataSource.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/7.
//  Copyright © 2018年 wangyuan. All rights reserved.
//
import UIKit



class ChatListTableViewDataSource: NSObject, UITableViewDataSource {
    var items = [FriendModel]()
    let kChatListCellIdentifier: String = "ChatListCellIdentifier"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatListCellIdentifier, for: indexPath) as! ChatListTableCell
        cell.configureWithItem(items[indexPath.row])
        return cell
    }
    
    func removeAtIndex(_ indexPathRow: Int) {
        self.items.remove(at: indexPathRow)
    }
}
