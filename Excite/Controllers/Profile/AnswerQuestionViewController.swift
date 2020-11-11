//
//  AnswerQuestionViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 8/30/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit

protocol AnswerQuestionViewControllerDelegate: class {
    func didEditFreeResponse(freeResponse: [FreeResponse])
}

class Colors {
var gl : CAGradientLayer

init() {
    let colorTop = UIColor(hexString: "6CA0FF").cgColor
    let colorBottom = UIColor(hexString: "FF6299").cgColor

    self.gl = CAGradientLayer()
    self.gl.colors = [colorTop, colorBottom]
    self.gl.locations = [0.0, 1.0]
}
}

class AnswerQuestionViewController: UIViewController {
    var question: String?
    var imageView = UIImageView()
    var answerTF = UITextField()
    var index: Int?
    weak var delegate: AnswerQuestionViewControllerDelegate?
    public var profile: Profile?
    var freeResponse: [FreeResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
         make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
         make.left.equalTo(20)
         make.right.equalTo(-20)
        }


        let backgroundLayer = Colors().gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)

        let questionText = UILabel()
        stackView.addArrangedSubview(questionText)

        questionText.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            //make.height.equalTo(40)
        }
        guard let question = question else { return }
        questionText.text = question
        questionText.numberOfLines = 3
        questionText.font = UIFont.systemFont(ofSize: 25)
        questionText.textColor = .white

        stackView.addArrangedSubview(answerTF)
            
        answerTF.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        answerTF.placeholder = "Your response here..."
        answerTF.font = UIFont.systemFont(ofSize: 15)
        answerTF.borderStyle = .roundedRect
        answerTF.autocorrectionType = UITextAutocorrectionType.no
        answerTF.keyboardType = UIKeyboardType.default
        answerTF.returnKeyType = UIReturnKeyType.done
        answerTF.clearButtonMode = .whileEditing
        
        
        let editButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(action))
        self.navigationItem.rightBarButtonItem  = editButton
    }
    
    @objc func action(sender: UIBarButtonItem) {
        guard let question = question, var freeResponse = freeResponse, let index = index else { return }
        let current = FreeResponse(question: question, answer: answerTF.text ?? "", image: "")
        
        freeResponse[index] = current
        delegate?.didEditFreeResponse(freeResponse: freeResponse)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectImage() {
        ImagePickerManager().pickImage(self) { image in
            self.imageView.image = image
        }
    }

}
