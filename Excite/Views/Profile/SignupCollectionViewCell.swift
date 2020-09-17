//
//  SignupCollectionViewCell.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/14/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

class SignupCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "photo"

    let label: UILabel = {
        let curr = UILabel()
        curr.text = "Label"
        curr.font = UIFont.systemFont(ofSize: 20)
        curr.textAlignment = .right
        curr.textColor = .black
        curr.backgroundColor = .yellow
        return curr
    }()
    func initialize() {
        self.addSubview(label)
        self.layer.backgroundColor = UIColor.blue.cgColor
        label.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.center.equalToSuperview().inset(30)
        }
    }
    
}

