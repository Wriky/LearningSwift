//
//  NewsViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/4.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

struct NewsListTableItem {
    let iconStr: String
    let titleStr: String
    let subTitleStr: String
}

class NewsViewController: BaseViewController {
    let kNewsListCellIdentifier = "NewsListCellIdentifier"
    
    private var items = [NewsListTableItem]()
    
    
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
        
        self.getOnlineData()
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
    
    func getOnlineData() {
        let contentArray = ["香蜜沉沉烬如霜很好看", "今天天气不错", "沁园春.雪❄️"]
        
        for (index, _) in contentArray.enumerated() {
            items.append(NewsListTableItem(iconStr: "[棒棒糖]", titleStr: "重大新闻", subTitleStr: contentArray[index]))
        }
        self.tableView.reloadData()
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
        return UITableViewAutomaticDimension
    }
}
