//
//  ChatFaceView.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatFaceView: BaseView {

    private lazy var showingListView: EmotionListView = {
        let showingListView: EmotionListView = EmotionListView()
        
        return showingListView
    }()
    
    private lazy var emojiListView: EmotionListView = {
        let emojiListView: EmotionListView = EmotionListView()
        
        return emojiListView
    }()
    
    private lazy var customListView: EmotionListView = {
        let customListView: EmotionListView = EmotionListView()
        
        return customListView
    }()
    
    private lazy var gifListView: EmotionListView = {
        let gifListView: EmotionListView = EmotionListView()
        
        return gifListView
    }()
    
    private lazy var menuView:EmotionMenuView = {
        let menuView: EmotionMenuView = EmotionMenuView()
        
        return menuView
    }()
    

}
