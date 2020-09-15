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
        curr.textColor = .white
        return curr
    }()
    func initialize() {
        print("GOT INSIDE")
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
        }
    }
    
}

