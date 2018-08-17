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
        
        self.view.backgroundColor = UIColor.white
        
        self.configUI()
        self.addNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configUI() {
//        view.addSubview(chatMoreView)
//        view.addSubview(chatFaceView)
        view.addSubview(chatBar)

        self.makeConstraints()
    }
    
    func makeConstraints() {
        chatBar.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view)
            $0.height.equalTo(kTabBarHeight)
        }
        
//        chatMoreView.snp.makeConstraints {
//            $0.top.equalTo(kTabBarHeight)
//            $0.left.equalTo(view)
//            $0.size.equalTo(CGSize(width: kScreenWidth, height: kChatBarHeight))
//        }
//        
//        chatFaceView.snp.makeConstraints {
//            $0.edges.equalTo(chatMoreView)
//        }
    }

    func addNotification() {
         NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            self.keyBoardFrame = CGRect.zero
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main) { (notification) in
            
            let userInfo = notification.userInfo!
            let keyBoardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.keyBoardFrame = keyBoardSize
            let keyBoardHeight: CGFloat = self.keyBoardFrame.height
            let chatBarStatus: ChatToolBarStatus = self.chatBar.status
            
            if (chatBarStatus == .ShowKeyboard || chatBarStatus == .ShowFace || chatBarStatus == .ShowMore) && (keyBoardHeight <= kChatBarHeight) {
                return
            }            
            
            if self.delegate != nil {
                self.delegate?.didChangeChatToolBarHeight(height: self.keyBoardFrame.size.height+kTabBarHeight)
                self.chatBar.status = .ShowKeyboard
            }
        }
    }
    
    func adjustToolBarHeight(barHeight: CGFloat) {
        guard let changeTooBarHeight = delegate?.didChangeChatToolBarHeight(height: barHeight) else {
            return
        }
        changeTooBarHeight
    }
    
    //todo
    func showChatToolView(toolView:BaseView, fromHeight: CGFloat, toHeight: CGFloat, toolHeight: CGFloat) {
        view.addSubview(toolView)
        toolView.snp.makeConstraints {
            $0.top.equalTo(kTabBarHeight)
            $0.left.equalTo(view)
            $0.size.equalTo(CGSize(width: kScreenWidth, height: fromHeight))
        }
        
        if(toHeight > 0) {
            toolView.snp.updateConstraints {
                $0.height.equalTo(toHeight)
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.adjustToolBarHeight(barHeight: toolHeight)
        }) { (finished) in
            //toolView.removeFromSuperview()
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
                self.showChatToolView(toolView: self.chatFaceView, fromHeight: kChatBarHeight, toHeight: 0, toolHeight: kTabBarHeight+kChatBarHeight)
            } else {
                self.showChatToolView(toolView: self.chatFaceView, fromHeight: kTabBarHeight+kChatBarHeight, toHeight: kChatBarHeight, toolHeight: kTabBarHeight+kChatBarHeight)
                if(fromStatus != .ShowMore) {
                    UIView.animate(withDuration: 0.2) {
                        self.adjustToolBarHeight(barHeight: kTabBarHeight+kChatBarHeight)
                    }
                }
            }
        default://.showMore
            if(fromStatus == .ShowVoice || fromStatus == .Nothing) {
                self.showChatToolView(toolView: self.chatMoreView,fromHeight: kChatBarHeight, toHeight: 0, toolHeight: kTabBarHeight+kChatBarHeight)
            } else {
                self.showChatToolView(toolView: self.chatMoreView,fromHeight: kChatBarHeight+kTabBarHeight, toHeight: kChatBarHeight, toolHeight: kTabBarHeight+kChatBarHeight)
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

