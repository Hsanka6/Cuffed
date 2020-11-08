//
//  SignupFinished.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/7/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

class SignupFinishedCardView: UIView {
    var finishSignupCompletion: ()->()?
    init(frame: CGRect, finishSignupCompletion: @escaping() -> Void) {
        self.finishSignupCompletion = finishSignupCompletion
        super.init(frame: frame)
        let questionLabel = UILabel()
        questionLabel.backgroundColor = .white
        questionLabel.numberOfLines = 3
        questionLabel.textColor = UIColor.black
        questionLabel.text = "You're done!"
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        let finishButton = UIButton()
        finishButton.setTitle("Start Matching", for: .normal)
        finishButton.backgroundColor = .blue
        finishButton.tintColor = .white
        finishButton.layer.cornerRadius = 15
        self.addSubview(finishButton)
        finishButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        finishButton.isUserInteractionEnabled = true
        finishButton.addTarget(self, action: #selector(self.finishButtonTapped), for: .touchUpInside)
        // render a button here with a completion handler for addAction
        // with objc function that calls the viewController's pushViewController function
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func finishButtonTapped() {
        self.finishSignupCompletion()
    }
}
