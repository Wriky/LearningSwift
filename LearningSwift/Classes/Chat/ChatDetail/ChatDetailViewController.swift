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
    private let kCellIdentifier: String = "ChatDetailCellIdentifier"
    var items = [MessageTableItem]()
    let appDelegate: AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
    var itemModel: FriendModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = RGB(237, 237, 246)
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
        self.title = (itemModel?.user?.nick_name)!
        
        self.configUI()
        self.getOnlineData()
        
    }
    
    func configUI() {
        
        self.addChildViewController(toolBarVC)
        view.addSubview(toolBarVC.view)
        
        view.addSubview(tableView);

        toolBarVC.view.snp.makeConstraints {
            $0.left.right.equalTo(view)
            $0.bottom.equalTo(0)
            $0.height.equalTo(kTabBarHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalTo(view)
            $0.height.equalTo(kScreenHeight-kTabBarHeight-kNavBarHeight)
        }
        self.addTapGestureOnTableView()
    }
    
    func getOnlineData() {
        let contentArray = ["香蜜沉沉烬如霜很好看", "今天天气不错", "沁园春.雪❄️"]
        
        for (index, _) in contentArray.enumerated() {
            items.append(MessageTableItem(nameStr: (itemModel?.user?.nick_name)!, timeStr: "2018-08-08", contentStr: contentArray[index]))
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
            self.tableView.scrollToRow(at: NSIndexPath.init(row: self.items.count-1, section: 0) as IndexPath, at: .bottom, animated: false)
        }
    }
    
    func addMessage(message: String, isSender:Bool) {
        appDelegate.client?.publish((self.itemModel?.user?.nick_name)!, message, (self.itemModel?.channel?.code)!)
        
        self.items.append(MessageTableItem(nameStr: (itemModel?.user?.nick_name)!, timeStr: "2018-08-10", contentStr: message))
        self.tableView.reloadData()
        self.scrollToBottom()
    }
}


extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ChatDetailTableCell
        let isLeft: Bool = (indexPath.row % 2 == 0)
        cell.configureWithItem(items[indexPath.row], isLeft: isLeft)
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
            $0.height.equalTo(height)
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
