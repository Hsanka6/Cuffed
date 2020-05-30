//
//  FindDateViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/27/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class FindDateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
              
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       super.viewWillAppear(animated)
       self.tabBarController?.navigationItem.hidesBackButton = true
    }
}
