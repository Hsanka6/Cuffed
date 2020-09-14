//
//  UserPeronalityTableViewCell.swift
//  Excite
//
//  Created by Haasith Sanka on 8/20/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

class UserPersonalityTableViewCell: UITableViewCell {
    static var reuseIdentifier = "personalityDetail"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(model: Personality) {
        let slider = CustomSlider()
        //slider.center = self.center
        slider.minimumTrackTintColor = .gray
        slider.maximumTrackTintColor = .blue
        slider.thumbTintColor = .black
        slider.setThumbImage(slider.makeCircleWith(size: CGSize(width: 25, height: 25), backgroundColor: .blue), for: .normal)
        slider.setThumbImage(slider.makeCircleWith(size: CGSize(width: 25, height: 25), backgroundColor: .blue), for: .highlighted)


        slider.maximumValue = 4
        slider.minimumValue = 0
        if let sliderVal = Float(model.answer) {
            slider.setValue( sliderVal, animated: false)
        }
        slider.addTarget(self, action: #selector(self.changeValue(_:)), for: .valueChanged)

        print(self.frame.width)
        self.addSubview(slider)
        
        let width = UIScreen.main.bounds.width - 40
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
        }
        let xPos = CGFloat(0)

        for size in 0..<5 {
            let tick = UIView(frame: CGRect(x: xPos + (UIScreen.main.bounds.width - 40) * (0.25 * CGFloat(size)), y: (slider.frame.size.height - 24) / 2, width: 2, height: 15))
            tick.backgroundColor = UIColor.init(white: 0.7, alpha: 1)
            tick.layer.shadowColor = UIColor.red.cgColor
             tick.tag = 1
            slider.insertSubview(tick, belowSubview: slider)
        }
        
        let leftValue = UILabel()
        leftValue.textAlignment = .left
        leftValue.textColor = UIColor.black
        leftValue.text = model.bottomValue
        let rightValue = UILabel()
        rightValue.textAlignment = .left
        rightValue.textColor = UIColor.black
        rightValue.text = model.topValue
        
        self.addSubview(leftValue)
        self.addSubview(rightValue)
        
        
        
        
        rightValue.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.right.equalTo(-20)
        }
        
        leftValue.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(20)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func changeValue(_ sender: UISlider) {
        sender.value = Float(Int(sender.value) * 1)
    }

}
