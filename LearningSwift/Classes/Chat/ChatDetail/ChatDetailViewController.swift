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
    
    private lazy var toolBarVC: ChatDetailToolBarViewController = {
        let toolBarVC = ChatDetailToolBarViewController()
        toolBarVC.delegate = self
        return toolBarVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = nameStr
        
        self.configUI()
        self.getOnlineData()
        
    }
    
    func configUI() {
        view.addSubview(tableView);
        
        self.addChildViewController(toolBarVC)
        view.addSubview(toolBarVC.view)
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalTo(view)
            $0.height.equalTo(kScreenHeight-kTabBarHeight)
        }
        toolBarVC.view.snp.makeConstraints {
            $0.left.right.equalTo(view)
            $0.bottom.equalTo(0)
            $0.height.equalTo(kTabBarHeight)
        }
        
        self.addTapGestureOnTableView()
    }
    
    func getOnlineData() {
        let array = ["Eggs", "Milk", "Vegetables"]
        let contentArray = ["香蜜沉沉烬如霜很好看", "今天天气不错", "沁园春.雪❄️"]
        
        for (index, value) in array.enumerated() {
            items.append(MessageTableItem(nameStr: value, timeStr: "2018-08-08", contentStr: contentArray[index]))
        }
        self.tableView.reloadData()
    }
    
    func addTapGestureOnTableView() {
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(tapTableView(_:)))
        self.tableView.addGestureRecognizer(singleTap)
    }
    
    @objc func tapTableView(_ gesture: UITapGestureRecognizer) {
        toolBarVC.view.endEditing(true)
        self.didChangeChatToolBarHeight(height: kTabBarHeight)
    }
    
    func scrollToBottom() {
        if self.items.count > 0 {
            self.tableView.scrollToRow(at: NSIndexPath.init(row: self.items.count-1, section: 0) as IndexPath, at: .bottom, animated: true)
        }
    }
    
    func addMessage(message: String, isSender:Bool) {
        self.items.append(MessageTableItem(nameStr: "superMan", timeStr: "2018-08-10", contentStr: message))
        self.tableView.reloadData()
        self.scrollToBottom()
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

extension ChatDetailViewController: ChatDetailToolBarViewControllerDelegate {
    
    func didChangeChatToolBarHeight(height: CGFloat) {
        self.toolBarVC.view.snp.updateConstraints {
            $0.bottom.equalTo(-height+kTabBarHeight)
        }
        
        
        self.tableView.snp.updateConstraints {
            $0.height.equalTo(kScreenHeight-height-kNavBarHeight)
        }
        
        if height == kTabBarHeight {
            self.tableView.reloadData()
        }else {
            self.scrollToBottom()
        }
    }
    
    func sendTextMessage(textStr: String) {
        self.addMessage(message: textStr, isSender: true)
    }
    
    func sendImageMessage(image: UIImage, imagePath: String) {
        
    }
    
    func sendVoiceMessage(voicePath: String) {
        
    }
    
    
}
