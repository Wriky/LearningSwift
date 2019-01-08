//
//  ChatDetailViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/8.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatDetailViewController: BaseViewController {
    private let kCellIdentifier: String = "ChatDetailCellIdentifier"
    var items = [MessageModel]()
    let appDelegate: AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
    var itemModel: FriendModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = RGB(237, 237, 246)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
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
        self.addNotification()
    }
    
    func configUI() {
        
        self.addChild(toolBarVC)
        view.addSubview(toolBarVC.view)
        
        view.addSubview(tableView);

        toolBarVC.view.snp.makeConstraints {
            $0.left.right.equalTo(view)
            $0.bottom.equalTo(0)
            $0.height.equalTo(kTabBarHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalTo(view)
            $0.height.equalTo(kScreenHeight-kTabBarHeight)
        }
        self.addTapGestureOnTableView()
    }
    
    func getOnlineData() {

        RequestHelper.loadMessageHistory((itemModel?.channel?.code)!) { (messgeList) in
            self.items = messgeList
            
            self.tableView.reloadData()
            self.scrollToBottom()
            print("receive message")
        }
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
        
//        self.items.append(MessageModel(msg_id: "1", content: message, msg_type: 1, user_id: (itemModel?.user_id)!, channel_code: (itemModel?.channel?.code)!, channel_type: 1))
        self.tableView.reloadData()
        self.scrollToBottom()
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(recieveMessage(_:)), name: Notification.Name(rawValue: RecieveMessageNotification) , object: nil)
    }
    
    @objc func recieveMessage(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.getOnlineData()
        }
    }
}


extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ChatDetailTableCell
        cell.configureWithItem(items[indexPath.row], (self.itemModel?.user)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        
        RequestHelper.sendMessageInfo(textStr, (itemModel?.channel?.code)!) { messageObject in
            
        }
    }
    
    func sendImageMessage(image: UIImage, imagePath: String) {
        
    }
    
    func sendVoiceMessage(voicePath: String) {
        
    }
}
