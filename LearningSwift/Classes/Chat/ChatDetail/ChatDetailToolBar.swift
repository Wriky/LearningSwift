//
//  ChatDetailToolBar.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class ChatDetailToolBar: BaseView {
    
    private lazy var topLineLbl: UILabel = {
        let topLineLbl = UILabel()
        topLineLbl.backgroundColor = RGBSame(165)
        return topLineLbl
    }()
    
    public lazy var voiceButton: UIButton = {
       let voiceButton = UIButton()
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoice"), for: UIControlState.normal)
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoiceHL"), for: UIControlState.highlighted)
        voiceButton.addTarget(self, action: #selector(voiceButtonClick(_:)), for: UIControlEvents.touchUpInside)
        return voiceButton
    }()
    
    public lazy var moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtn_Black"), for: UIControlState.normal)
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtnHL_Black"), for: UIControlState.highlighted)
        moreButton.addTarget(self, action: #selector(moreButtonClick(_:)), for: UIControlEvents.touchUpInside)
        return moreButton
    }()
    
    public lazy var faceButton: UIButton = {
        let faceButton = UIButton()
        faceButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState.normal)
        faceButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
        faceButton.addTarget(self, action: #selector(faceButtonClick(_:)), for: UIControlEvents.touchUpInside)
        return faceButton
    }()
    
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = RGBSame(165).cgColor
        textView.scrollsToTop = false
        textView.returnKeyType = UIReturnKeyType.send
        textView.delegate = self
        return textView
    }()
    
    public lazy var talkButton: UIButton = {
        let talkButton = UIButton()
        talkButton.setTitle("按住 说话", for: .normal)
        talkButton.setTitle("松开 结束", for: .highlighted)
        talkButton.setTitleColor(RGBSame(76.5), for: .normal)
        talkButton.setBackgroundImage(UIImage().fillImageWithColor(color: RGBASame(178.5, 0.5)), for: .highlighted)
        talkButton.layer.masksToBounds = true
        talkButton.layer.cornerRadius = 4
        talkButton.layer.borderWidth = 0.5
        talkButton.layer.borderColor = RGBSame(165).cgColor
        talkButton.isHidden = true
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchDown)
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchUpInside)
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchUpOutside)
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchCancel)
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchDragOutside)
        talkButton.addTarget(self, action: #selector(talkButtonClick(_:)), for: .touchDragInside)

        return talkButton
    }()
    
    @objc func voiceButtonClick(_ button: UIButton) {
        
    }
    
    @objc func moreButtonClick(_ button: UIButton) {
        
    }
    
    @objc func faceButtonClick(_ button: UIButton) {
        
    }
    
    @objc func talkButtonClick(_ button: UIButton) {
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
       
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        
    }
}

extension ChatDetailToolBar: UITextViewDelegate {
    
}
