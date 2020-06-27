//
//  DatingAudioVideoViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 6/19/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class DatingAudioVideoViewController: UIViewController,UITextFieldDelegate {

    var startDateButton = UIButton()
    var verticalStackview = UIStackView(frame: .zero)
    var horizontalStackview = UIStackView(frame: .zero)
    var roomTextField = UITextField()
    var roomLabel = UILabel()
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
        let width = UIScreen.main.bounds.width - 20
        self.view.addSubview(startDateButton)
        self.view.addSubview(horizontalStackview)
        self.view.addSubview(verticalStackview)
        horizontalStackview.addSubview(roomLabel)
        horizontalStackview.addSubview(roomTextField)
        verticalStackview.addSubview(horizontalStackview)
        verticalStackview.addSubview(startDateButton)
        verticalStackview.spacing = 10.0

        //
        verticalStackview.axis = .vertical
        horizontalStackview.axis = .horizontal
        //label and text field constraints
        roomLabel.text = "Room Name"
        roomLabel.textAlignment = .left
        roomLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(width/2)
        }
        roomTextField.placeholder = "Room #"
        roomTextField.textAlignment = .left
        roomTextField.backgroundColor = UIColor.red
        roomTextField.returnKeyType = UIReturnKeyType.done
        roomTextField.keyboardType = UIKeyboardType.default
        roomTextField.font = UIFont.systemFont(ofSize: 16)
        roomTextField.delegate = self
        roomTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(width/2)
        }
        horizontalStackview.snp.makeConstraints { make in
            make.height.equalTo(roomLabel.snp.height)
            //make.bottom.equalTo(startDateButton.snp.top)
        }
        let views = [roomLabel, roomTextField]
        var leftHandView: UIView?
        for view in views {
            horizontalStackview.addSubview(view)
            view.backgroundColor = UIColor.init(hexString: "ffffff")

            view.snp.makeConstraints { make in
                make.bottom.equalTo(startDateButton.snp.top).offset(10)
                if let leftHandView = leftHandView {
                    make.left.equalTo(leftHandView.snp.right)
                    make.width.equalTo(leftHandView)
                }
                leftHandView = view
            }
        }
        startDateButton.backgroundColor = .red
        startDateButton.setTitle("Connect", for: .normal)
        startDateButton.snp.makeConstraints { (make) -> Void in
           make.height.equalTo(40)
           make.width.equalTo(width)
        }
        startDateButton.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
        verticalStackview.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(width)
            make.center.equalTo(self.view)
        }
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
