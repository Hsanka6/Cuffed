//
//  DatingAudioVideoViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 6/19/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class DatingAudioVideoViewController: UIViewController {

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
        let width = UIScreen.main.bounds.width - 20
        startDateButton.backgroundColor = .red
        startDateButton.setTitle("Connect", for: .normal)
        startDateButton.snp.makeConstraints { (make) -> Void in
           make.height.equalTo(40)
           make.width.equalTo(width)
           make.center.equalTo(self.view)
        }
        startDateButton.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
    }
    @objc func connect(sender: UIButton!) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
