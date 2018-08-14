//
//  EmotionMenuView.swift
//  LearningSwift
//

//  Created by wangyuan on 2018/8/14.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class EmotionMenuView: BaseView {
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    private lazy var sendBtn: UIButton = {
        let sendBtn: UIButton = UIButton()
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sendBtn.backgroundColor = RGB(25.5, 102, 204)
        sendBtn.addTarget(self, action: #selector(sendBtnClicked(_:)), for: .touchUpInside)
        return sendBtn
    }()

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        let emojiBtn: UIButton =  self.setupMenuBtnWithType(title: "Custom", buttonType: .Emoji)
        let customBtn: UIButton = self.setupMenuBtnWithType(title: "Custom", buttonType: .Custom)
        
        self.addSubview(emojiBtn)
        self.addSubview(customBtn)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW: CGFloat = 60
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.width-btnW, height: self.height)
        self.sendBtn.frame = CGRect(x: self.width-btnW, y: 0, width: btnW, height: self.height)
        
        for (index, value) in self.scrollView.subviews.enumerated() {
            let btn: UIButton = value as! UIButton
            btn.x = btnW * CGFloat(index)
            btn.y = 0
            btn.width = btnW
            btn.height = self.height
            
        }
    }
    
    
    func setupMenuBtnWithType(title: String, buttonType: EmotionMenuButtonType) -> UIButton{
        let btn: UIButton = UIButton()
        btn.tag = (buttonType).rawValue
        if title.elementsEqual("Custom") {
            btn.setImage(UIImage.init(named: "[吓]"), for: .normal)
        } else {
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 26.5)
        }
        btn.addTarget(self, action: #selector(menuBtnClicked(_:)), for: .touchUpInside)
        btn.setBackgroundImage(UIImage().fillImageWithColor(color: UIColor.white), for: .normal)
        btn.setImage(UIImage().fillImageWithColor(color: RGBSame(241)), for: .selected)
        return btn
    }
    
    @objc func sendBtnClicked(_ button: UIButton) {
        
    }
    
    @objc func menuBtnClicked(_ button: UIButton) {
        
    }
}
