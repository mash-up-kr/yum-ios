//
//  NotiViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 1. 19..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

class NotiViewController: UIViewController {
    @IBOutlet weak var tableView: NotiTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.initiate()
    }
}
