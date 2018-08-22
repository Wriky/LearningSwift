//
//  ChatFaceView.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

let bottomViewH: CGFloat = 36


class ChatFaceView: BaseView {
    weak var showingListView: EmotionListView?
    
    private lazy var emojiListView: EmotionListView = {
        let emojiListView: EmotionListView = EmotionListView()
        emojiListView.setEmotions(FaceManager.emojiEmotion())
        return emojiListView
    }()
    
    private lazy var customListView: EmotionListView = {
        let customListView: EmotionListView = EmotionListView()
        customListView.setEmotions(FaceManager.customEmotion())
        return customListView
    }()
    
    private lazy var gifListView: EmotionListView = {
        let gifListView: EmotionListView = EmotionListView()
        
        return gifListView
    }()
    
    private lazy var menuView:EmotionMenuView = {
        let menuView: EmotionMenuView = EmotionMenuView()
        menuView.setDelegate(self)
        return menuView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGB(237, 237, 246)
        
        self.addSubview(menuView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.menuView.width         = self.width
        self.menuView.height        = bottomViewH
        self.menuView.x             = 0;
        self.menuView.y             = self.height - self.menuView.height
        
        self.showingListView?.y = 0
        self.showingListView?.x      = 0
        self.showingListView?.width  = self.width
        self.showingListView?.height = self.menuView.y
        
    }
}

extension ChatFaceView: EmotionMenuViewDelegate {
    
    func emotionMenuDidSelectButton(menuView: EmotionMenuView, buttonType: EmotionMenuButtonType) {
        self.showingListView?.removeFromSuperview()
        switch buttonType {
        case .Emoji:
            self.addSubview(self.emojiListView)
        case .Custom:
            self.addSubview(self.customListView)
        default:
            self.addSubview(self.gifListView)
        }

        self.showingListView = self.subviews.last as? EmotionListView
        self.setNeedsLayout()
    }
}
