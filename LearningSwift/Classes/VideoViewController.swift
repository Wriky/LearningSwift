//
//  VideoViewController.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/6/24.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import UIKit



class VideoViewController: UIViewController {

    @IBOutlet weak var goCom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
       
    }

    @IBAction func clickGoButton(_ sender: Any) {
        print("clickGoButton")
        
        let vc = CommunityViewController.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

