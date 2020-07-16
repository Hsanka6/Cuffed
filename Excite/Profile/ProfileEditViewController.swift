//
//  ProfileEditViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 7/16/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {

     override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           print("SETUP")
           setupUI()
       }

    func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.centerX.equalToSuperview()
        }
        stackView.addArrangedSubview(makeStackViewOfImages())
        stackView.addArrangedSubview(makeStackViewOfImages())
    }

    func makeStackViewOfImages() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        for _ in 0...2 {
            stackView.addArrangedSubview(makeImageView())
        }
        return stackView
    }
    func makeImageView() -> UIImageView {
        let image = UIImageView(image: UIImage(named: "user"))
        let widthOfImage = UIScreen.main.bounds.width/3 - (40/3)
        image.snp.makeConstraints { (make) in
            make.width.equalTo(widthOfImage)
            make.height.equalTo(100)
        }
        return image
    }
}
