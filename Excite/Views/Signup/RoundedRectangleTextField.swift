//
//  SignupTextField.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/9/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit
class RoundedRectangleTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        layer.cornerRadius  = 10.0
        layer.borderWidth   = 2.0
        layer.borderColor   = UIColor.white.cgColor
        
        textAlignment   = .center
        textColor       = .white
        font            = UIFont.systemFont(ofSize: 20)
        
        keyboardAppearance  = .dark
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
