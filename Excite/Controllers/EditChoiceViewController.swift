//
//  EditChoiceViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 8/31/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class EditChoiceViewController: UIViewController {

    let button = MultipleChoiceButton()
          
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        button.setupButton()
        self.view.addSubview(button)
        button.setTitle("Button", for: .normal)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        button.addTarget(self, action: #selector(selected), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func selected() {
        button.select = !button.select
        if button.select {
            button.selectedStyling()
        } else {
            button.setupButton()
        }
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
