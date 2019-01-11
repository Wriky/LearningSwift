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

        self.maxBehotTime = Date().timeIntervalSince1970

        NewsViewModel.requestNewsData(category: .hot, ttFrom: .pull, pullTime: self.maxBehotTime, success: { (response) in
            
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            self.items = response as! [NewsModel]
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func loadMoreOnlineData() {
        
        NewsViewModel.requestMoreNewsData(category: .hot, ttFrom: .loadMore, pullTime: self.maxBehotTime, listCount: self.items.count, success: { (response) in
            self.tableView.mj_footer.pullingPercent = 0
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
            let news = response as! [NewsModel]
            if news.count == 0 {
                SVProgressHUD.showInfo(withStatus: "没有更多数据啦！")
                return
            }
            self.items += news
            self.tableView.reloadData()
        }) { (error) in
            
        }
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

