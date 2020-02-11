//
//  EmptyView.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var messageLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        l.numberOfLines = 4
        l.textAlignment = .center
        return l
    }()
    
    init(_ title: String, message: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        messageLabel.text = message
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
      setupMessageLabelConstraints()
      setupTitleLabelConstraints()
    }
    
    private func setupMessageLabelConstraints() {
      addSubview(messageLabel)
      messageLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
      ])
    }
    
    private func setupTitleLabelConstraints() {
      addSubview(titleLabel)
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
      ])
      
    }
}
