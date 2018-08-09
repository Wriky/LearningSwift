//
//  ChatDetailToolBarViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

protocol ChatDetailToolBarViewControllerDelegate: class {
    func didChangeChatToolBarHeight(height: CGFloat)
    func sendTextMessage(textStr: String)
    func sendImageMessage(image: UIImage, imagePath: String)
    func sendVoiceMessage(voicePath: String)
}

class ChatDetailToolBarViewController: BaseViewController {
    var keyBoardFrame: CGRect = CGRect.zero
    weak var delegate: ChatDetailToolBarViewControllerDelegate?
    
    private lazy var chatBar: ChatDetailToolBar = {
        let chatBar = ChatDetailToolBar()
        chatBar.delegate = self
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
        self.addNotification()
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
    
    func adjustToolBarHeight(barHeight: CGFloat) {
        
    }
    
    //todo
    func showChatFaceView(fromHeight: CGFloat, toHeight: CGFloat) {
        view.addSubview(self.chatFaceView)
        self.chatFaceView.snp.makeConstraints {
            $0.top.equalTo(kTabBarHeight)
            $0.left.equalTo(view)
            $0.size.equalTo(CGSize(width: kScreenWidth, height: fromHeight))
        }
        
        if(toHeight < fromHeight) {
            self.chatFaceView.snp.updateConstraints {
                $0.height.equalTo(toHeight)
            }
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.adjustToolBarHeight(barHeight: toHeight)
        }) { (finished) in
            self.chatFaceView.removeFromSuperview()
        }
    }
    
    func showChatMoreView(fromHeight: CGFloat, toHeight: CGFloat) {
        view.addSubview(self.chatMoreView)
        self.chatMoreView.snp.makeConstraints {
            $0.top.equalTo(kTabBarHeight)
            $0.left.equalTo(view)
            $0.size.equalTo(CGSize(width: kScreenWidth, height: fromHeight))
        }
        
        if(toHeight < fromHeight) {
            self.chatMoreView.snp.updateConstraints {
                $0.height.equalTo(toHeight)
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.adjustToolBarHeight(barHeight: toHeight)
        }) { (finished) in
            self.chatMoreView.removeFromSuperview()
        }
    }
}

extension ChatDetailToolBarViewController: ChatDetailToolBarDelegate {
    
    func changeStatus(fromStatus: ChatToolBarStatus, toStatus: ChatToolBarStatus) {
        switch toStatus {
        case .ShowKeyboard:
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.chatMoreView.removeFromSuperview()
                self.chatFaceView.removeFromSuperview()
            }
        case .ShowVoice:
            UIView.animate(withDuration: 0.3, animations: {
                self.adjustToolBarHeight(barHeight: kTabBarHeight)
            }) { (finished) in
                self.chatMoreView.removeFromSuperview()
                self.chatFaceView.removeFromSuperview()
            }
        case .ShowFace:
            if(fromStatus == .ShowVoice || fromStatus == .Nothing) {
                self.showChatFaceView(fromHeight: kChatBarHeight, toHeight: kTabBarHeight+kChatBarHeight)
            } else {
                self.showChatFaceView(fromHeight: kTabBarHeight+kChatBarHeight, toHeight: kChatBarHeight)
                if(fromStatus != .ShowMore) {
                    UIView.animate(withDuration: 0.2) {
                        self.adjustToolBarHeight(barHeight: kTabBarHeight+kChatBarHeight)
                    }
                }
            }
        default://.showMore
            if(fromStatus == .ShowVoice || fromStatus == .Nothing) {
                self.showChatMoreView(fromHeight: kChatBarHeight, toHeight: kChatBarHeight+kTabBarHeight)
            } else {
                self.showChatMoreView(fromHeight: kChatBarHeight+kTabBarHeight, toHeight: kChatBarHeight)
            }
       }
    }
    
    func sendTextMessage(textStr: String) {
        guard let sendMessage = delegate?.sendTextMessage(textStr: textStr) else {
            return
        }
        sendMessage
    }
    
    func changeToolBarHeight(height: CGFloat) {
        
    }
    
    
}

