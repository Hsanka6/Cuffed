//
//  UnderlinedTextField.swift
//  Excite
//
//  Created by Jan Ephraim Nino Tanja on 9/10/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import Foundation
import UIKit
class UnderlinedTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        textColor       = .white
        textAlignment   = .right
        textColor       = .white
        font            = UIFont.systemFont(ofSize: 30)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
