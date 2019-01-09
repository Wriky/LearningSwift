//
//  NewsViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/4.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewsViewController: BaseViewController {
    let kNewsListCellIdentifier = "NewsListCellIdentifier"
    
    //数据
    private var items = [NewsModel]()
    
    //刷新时间
    var maxBehotTime: TimeInterval = 0.0
    
    var newsRequest: NewsRequest!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self;
        tableView.register(NewsListTableCell.self, forCellReuseIdentifier: kNewsListCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        
        self.loadOnlineData()
        
        self.setupRefresh()
    }
    
    func configUI() {
        view.addSubview(tableView)
        
        self.makeconstraints()
    }
    
    func makeconstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func loadOnlineData() {
//        RequestHelper.loadNewsFeeds(category: .hot, ttFrom: .pull) { (timeInterval, news) in
//            if self.tableView.mj_header.isRefreshing {
//                self.tableView.mj_header.endRefreshing()
//            }
//
//            self.maxBehotTime = timeInterval
//            self.items = news
//
//            self.tableView.reloadData()
//        }
        
    }
    
    func loadMoreOnlineData() {
        
//        RequestHelper.loadMoreNewsFeeds(category: .hot, ttFrom: .loadMore, maxBehotTime: self.maxBehotTime, listCount: self.items.count) { (news) in
//
//            self.tableView.mj_footer.pullingPercent = 0
//            if self.tableView.mj_footer.isRefreshing {
//                self.tableView.mj_footer.endRefreshing()
//            }
//
//            if news.count == 0 {
//                SVProgressHUD.showInfo(withStatus: "没有更多数据啦！")
//                return
//            }
//
//            self.items += news
//            self.tableView.reloadData()
//        }
        
        
        
        
    }
    
    func setupRefresh() {
        let header = RefreshHeader { [weak self] in
            self?.loadOnlineData()
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        
        
        let gifFooter = RefreshAutoGifFooter { [weak self] in
            self?.loadMoreOnlineData()
        }
        tableView.mj_footer = gifFooter
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNewsListCellIdentifier, for: indexPath) as! NewsListTableCell
        cell.configureWithItem(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc: NewsDetailViewController = NewsDetailViewController()
        vc.detailModel = items[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController:
