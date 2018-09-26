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
    var status: ChatToolBarStatus = .Nothing
    
    private lazy var topLineLbl: UILabel = {
        let topLineLbl = UILabel()
        topLineLbl.backgroundColor = RGBSame(165)
        return topLineLbl
    }()
    
    public lazy var voiceButton: UIButton = {
       let voiceButton = UIButton()
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoice"), for: UIControl.State.normal)
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoiceHL"), for: UIControl.State.highlighted)
        voiceButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: UIControl.State.selected)
        voiceButton.addTarget(self, action: #selector(voiceButtonClick(_:)), for: UIControl.Event.touchUpInside)
        return voiceButton
    }()
    
    public lazy var moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtn_Black"), for: .normal)
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtnHL_Black"), for: .highlighted)
        moreButton.addTarget(self, action: #selector(moreButtonClick(_:)), for: .touchUpInside)
        return moreButton
    }()
    
    public lazy var faceButton: UIButton = {
        let faceButton = UIButton()
        faceButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: .normal)
        faceButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: .highlighted)
        faceButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: .selected)
        faceButton.addTarget(self, action: #selector(faceButtonClick(_:)), for: UIControl.Event.touchUpInside)
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
        let lastStatus = self.status
        
        let isShowVoice: Bool = (lastStatus == .ShowVoice)
        self.talkButton.isHidden = isShowVoice
        self.textView.isHidden = !isShowVoice
        self.voiceButton.isSelected = isShowVoice
        self.status = isShowVoice ? .ShowKeyboard : .ShowVoice
        
        if isShowVoice {
            self.textView.becomeFirstResponder()
        }else {
            self.textView.resignFirstResponder()
        }
        
        guard let changeStatus = delegate?.changeStatus(fromStatus: lastStatus, toStatus: self.status)  else {
            return
        }
        changeStatus
    }
    
    @objc func moreButtonClick(_ button: UIButton) {
        let lastStatus = self.status
        let isShowMore = (lastStatus == .ShowMore)
        
        if isShowMore {
            self.status = .ShowKeyboard
            self.textView.becomeFirstResponder()
        } else {
            self.talkButton.isHidden = true
            self.textView.isHidden = false
            self.voiceButton.isSelected = false
            self.status = .ShowMore
            
            if lastStatus == .ShowFace {
                self.faceButton.isSelected = false
            } else if lastStatus == .ShowKeyboard{
                self.textView.resignFirstResponder()
            }
        }
        
        guard let changeStatus = delegate?.changeStatus(fromStatus: lastStatus, toStatus: self.status) else {
            return
        }
        changeStatus
    }
    
    @objc func faceButtonClick(_ button: UIButton) {
        let lastStatus = self.status
        let isShowFace = (lastStatus == .ShowFace)
        if isShowFace {
            self.status = .ShowKeyboard
            self.faceButton.isSelected = false
            self.textView.becomeFirstResponder()
        } else {
            if lastStatus == .ShowKeyboard {
                self.textView.resignFirstResponder()
            }
            self.talkButton.isHidden = true
            self.textView.isHidden = false
            self.faceButton.isSelected = true
            self.voiceButton.isSelected = false
            self.status = .ShowFace
        }
        
        guard let changeStatus = delegate?.changeStatus(fromStatus: lastStatus, toStatus: self.status) else {
            return
        }
        changeStatus
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
    
    func emotionDidSelected(_ notification: Notification) {
        let emotion: WYEmotion = notification.userInfo![SelectEmotionKey] as! WYEmotion
        if !emotion.code.isEmpty {
            self.textView.insertText(emotion.code.emoji())
        self.textView.scrollRangeToVisible(NSMakeRange(self.textView.text.lengthOfBytes(using: String.Encoding.utf8), 0))
        } else {
            self.textView.insertText(emotion.face_name)
        }
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: EmotionDidSelectNotification), object: nil, queue: OperationQueue.main) { (notification) in
            self.emotionDidSelected(notification)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: EmotionDidDeleteNotification), object: nil, queue: OperationQueue.main) { (notification) in
            self.textView.deleteBackward()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: EmotionDidSendNotification), object: nil, queue: OperationQueue.main) { (notification) in
            if self.textView.text.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                if let sendTextMessage = self.delegate?.sendTextMessage(textStr: self.textView.text) {
                    sendTextMessage
                    
                    self.textView.text = ""
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
        self.addNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            $0.height.equalTo(0.5)
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.status = .ShowKeyboard
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.elementsEqual("\n") {
            if textView.text.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                if let sendTextMessage = delegate?.sendTextMessage(textStr: textView.text) {
                    sendTextMessage
                    
                    self.textView.text = ""
                }
            }
            
            return false
        }
        return true
    }
}


