//
//  EmotionListView.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/10.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class EmotionListView: BaseView {
    let topLineH: CGFloat = 0.5
    
    var emotions: NSArray = []

    private lazy var topLine: UIView = {
        let topLine: UIView = UIView()
        topLine.backgroundColor = RGBSame(188)
        return topLine
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configUI()
        
//        let currentVC = BaseViewController.currentViewController()
//        currentVC?.navigationController?.interactivePopGestureRecognizer?.require(toFail: self.scrollView.panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.pageControl.width = self.width
        self.pageControl.height = 10
        self.pageControl.x = 0
        self.pageControl.y = self.height - self.pageControl.height
        self.scrollView.width = self.width
        self.scrollView.height = self.pageControl.y
        self.scrollView.x = 0

        let count: Int = self.scrollView.subviews.count
        for index in 0 ..< count {
            let pageView = self.scrollView.subviews[index]
                pageView.width = self.scrollView.width
                pageView.height = self.scrollView.height
                pageView.y = 0
                pageView.x = CGFloat(index) * pageView.width
        }
        self.scrollView.contentSize = CGSize(width: CGFloat(count)*self.scrollView.width, height: 0)
    }
    
    func configUI() {
        self.backgroundColor = RGB(237, 237, 246)
        
        self.addSubview(topLine)
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        self.makeConstraints()
    }
    
    func makeConstraints() {
        topLine.snp.makeConstraints {
            $0.left.top.equalTo(0)
            $0.width.equalTo(kScreenWidth)
            $0.height.equalTo(topLineH)
        }
    }
    
    func setEmotions(_ emotions: NSArray) {
        self.emotions = emotions
        
        self.scrollView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        let count: Int = (emotions.count + EmotionPageSize - 1) / EmotionPageSize
        self.pageControl.numberOfPages = count
        for index in 0 ..< count {
            let pageView: EmotionPageView = EmotionPageView()
            pageView.backgroundColor = UIColor.white
            var range: NSRange = NSRange(location: index*EmotionPageSize, length: 0)
            let left: Int = emotions.count - range.location
            if left >= EmotionPageSize {
                range.length = EmotionPageSize
            } else {
                range.length = left
            }
            pageView.setEmotions(emotions.subarray(with: range) as! Array<WYEmotion>)
            self.scrollView.addSubview(pageView)
        }
        self.setNeedsLayout()
    }

}

extension EmotionListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageNum: CGFloat = CGFloat(scrollView.contentOffset.x / scrollView.width)
        self.pageControl.currentPage = Int(pageNum+0.5)
    }
}
