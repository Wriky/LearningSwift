//
//  ChatDetailToolBar.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

protocol ChatDetailToolBarDelegate: class {
    func changeStatus(fromStatus: ChatToolBarStatus, toStatus: ChatToolBarStatus)
    func sendTextMessage(textStr: String)
    func changeToolBarHeight(height: CGFloat)
}

class ChatDetailToolBar: BaseView {
    
    weak var delegate: ChatDetailToolBarDelegate?
    
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
        talkButton.addTarget(self, action: #selector(talkButtonDown(_:)), for: .touchDown)
        talkButton.addTarget(self, action: #selector(talkButtonUpInside(_:)), for: .touchUpInside)
        talkButton.addTarget(self, action: #selector(talkButtonUpOutside(_:)), for: .touchUpOutside)
        talkButton.addTarget(self, action: #selector(talkButtonTouchCancel(_:)), for: .touchCancel)
        talkButton.addTarget(self, action: #selector(talkButtonDragOutside(_:)), for: .touchDragOutside)
        talkButton.addTarget(self, action: #selector(talkButtonDragInside(_:)), for: .touchDragInside)

        return talkButton
    }()
    
    @objc func voiceButtonClick(_ button: UIButton) {
        
    }
    
    @objc func moreButtonClick(_ button: UIButton) {
        
    }
    
    @objc func faceButtonClick(_ button: UIButton) {
        
    }
    
    @objc func talkButtonDown(_ button: UIButton) {

    }
    
    @objc func talkButtonUpInside(_ button: UIButton) {
        
    }
    
    @objc func talkButtonUpOutside(_ button: UIButton) {
        
    }
    
    @objc func talkButtonTouchCancel(_ button: UIButton) {
        
    }
    
    @objc func talkButtonDragOutside(_ button: UIButton) {
        
    }
    
    @objc func talkButtonDragInside(_ button: UIButton) {
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(topLineLbl)
        self.addSubview(voiceButton)
        self.addSubview(faceButton)
        self.addSubview(moreButton)
        self.addSubview(talkButton)
        self.addSubview(textView)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        topLineLbl.snp.makeConstraints {
            $0.top.left.right.equalTo(self)
        }
        voiceButton.snp.makeConstraints {
            $0.top.equalTo(6)
            $0.left.equalTo(self)
            $0.size.equalTo(CGSize(width: 37, height: 37))
        }
        faceButton.snp.makeConstraints {
            $0.top.equalTo(voiceButton.snp.top)
            $0.right.equalTo(moreButton.snp.left).offset(-4)
            $0.size.equalTo(CGSize(width: 37, height: 37))
        }
        moreButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 37, height: 37))
            $0.top.equalTo(voiceButton.snp.top)
            $0.right.equalTo(self)
        }
        talkButton.snp.makeConstraints {
            $0.left.equalTo(voiceButton.snp.right).offset(4)
            $0.top.equalTo(kTabBarHeight * 0.13)
            $0.size.equalTo(CGSize(width: kScreenWidth-41*3, height: 37))
        }
        textView.snp.makeConstraints {
            $0.edges.equalTo(talkButton)
        }
    }
}

extension ChatDetailToolBar: UITextViewDelegate {
    
}
