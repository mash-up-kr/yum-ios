//
//  SearchResultViewController.swift
//  Yum
//
//  Created by Noverish Harold on 2018. 2. 2..
//  Copyright © 2018년 Mash-up. All rights reserved.
//

import UIKit

final class SearchResultViewController: UIViewController {
    var startCalorie: Int!
    var endCalorie: Int!
    var tag: String?
    var userName: String?
    
    @IBAction func backBtnClicked() {
        self.navigationController?.dismiss(animated: true)
    }
}
