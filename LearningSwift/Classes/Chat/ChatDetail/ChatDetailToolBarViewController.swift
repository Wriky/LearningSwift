//
//  ChatDetailToolBarViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatDetailToolBarViewController: BaseViewController {
    var keyBoardFrame: CGRect = CGRect.zero
    
    private lazy var chatBar: ChatDetailToolBar = {
        let chatBar = ChatDetailToolBar()
        chatBar.delegate = self as? ChatDetailToolBarDelegate
        return chatBar
    }()
    
    private lazy var chatMoreView: ChatMoreView = {
        let chatMoreView = ChatMoreView()
        
        return chatMoreView
    }()
    
    private lazy var chatFaceView: ChatFaceView = {
        let chatFaceView = ChatFaceView()
        return chatFaceView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    func configUI() {
        self.view.addSubview(chatMoreView)
        self.view.addSubview(chatFaceView)
        self.view.addSubview(chatBar)

        self.makeConstraints()
    }
    
    func makeConstraints() {
        chatBar.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view)
            $0.height.equalTo(kChatBarHeight)
        }
        
        chatMoreView.snp.makeConstraints {
            $0.top.equalTo(kTabBarHeight)
            $0.left.equalTo(view)
            $0.size.equalTo(CGSize(width: kScreenWidth, height: kChatBarHeight))
        }
        
        chatFaceView.snp.makeConstraints {
            $0.edges.equalTo(chatMoreView)
        }
    }

    func addNotification() {
         NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            self.keyBoardFrame = CGRect.zero
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil, queue: OperationQueue.main) { (notification) in
            
            let userInfo = notification.userInfo!
            let keyBoardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.keyBoardFrame = keyBoardSize
        }
    }
}

extension ChatDetailToolBarViewController: ChatDetailToolBarDelegate {
    func changeStatus(fromStatus: ChatToolBarStatus, toStatus: ChatToolBarStatus) {
        
    }
    
    func sendTextMessage(textStr: String) {
        
    }
    
    func changeToolBarHeight(height: CGFloat) {
        
    }
    
    
}

