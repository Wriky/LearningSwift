//
//  EmotionButton.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/14.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class EmotionButton: UIButton {
   
    var emotion: WYEmotion = WYEmotion()
    
    public func setEmotion(emotionParam: WYEmotion) {
        emotion = emotionParam
        if !emotion.code.isEmpty {
            self.setTitle(emotion.code, for: .normal)
        } else {
            self.setImage(UIImage.init(named: emotion.face_name), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        self.adjustsImageWhenHighlighted = false
    }
    
    
}
