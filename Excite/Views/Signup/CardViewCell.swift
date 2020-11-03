//
//  CardView.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 11/1/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit

// generic type for the SignupViewController that can hold a UI View
// for either a question or for a photos cell

//

class CardViewCell: UICollectionViewCell {
    static var reuseIdentifier: String = "signup-cell"
    
    func initialize(mainView: UIView) {
        let cardView = UIView()
        self.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 15
        cardView.snp.makeConstraints { (make) in
            make.height.equalTo(600)
            make.width.equalTo(UIScreen.main.bounds.width - 80)
            make.center.equalToSuperview()
        }
        self.addSubview(mainView)
        
        cardView.dropShadow()
//        cardView.addSubview(mainView)
    }
}
