//
//  BaseTableViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/7/4.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.theme_separatorColor = "colors.separatorViewColor"
        
        func setupRefresh() {
            
            let header = RefreshHeader { [weak self] in
                self!.tableView.reloadData()
            }
            
            header?.isAutomaticallyChangeAlpha = true
            header?.lastUpdatedTimeLabel.isHidden = true
            tableView.mj_header = header
            tableView.mj_header.beginRefreshing()
            
            let footer = RefreshAutoGifFooter { [weak self] in
                self!.tableView.reloadData()
            }
            tableView.mj_footer = footer
            tableView.mj_footer.isAutomaticallyChangeAlpha = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
