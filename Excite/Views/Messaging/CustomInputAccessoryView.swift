//
//  CustomInputAccessoryView.swift
//  CuffedChat
//
//  Created by Max He on 8/19/20.
//  Copyright © 2020 Max He. All rights reserved.
//

import UIKit

protocol CustomInputAccesssoryViewDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomInputAccesssoryViewDelegate?
    
    lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeHolderLabel.centerY(inView: messageInputTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeHolderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
    
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
    }
    
    
}
