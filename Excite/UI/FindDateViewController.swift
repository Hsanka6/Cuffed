//
//  FindDateViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 5/27/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class FindDateViewController: UIViewController {

    var startDateButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.tabBarController?.navigationItem.hidesBackButton = true
    }
    func makeUI() {
        self.view.addSubview(startDateButton)
        startDateButton.backgroundColor = .black
        startDateButton.setTitle("Login", for: .normal)
        startDateButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(200)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        startDateButton.addTarget(self, action: #selector(self.startDate), for: .touchUpInside)
    }

    @objc func startDate(sender: UIButton!) {
       print("startDate")
       let newViewController = DatingAudioVideoViewController()
       self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
