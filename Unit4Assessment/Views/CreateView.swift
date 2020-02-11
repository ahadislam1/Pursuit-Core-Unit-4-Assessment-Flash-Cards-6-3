//
//  CreateView.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a title..."
        tf.backgroundColor = .secondarySystemBackground
        tf.borderStyle = .bezel
        return tf
    }()
    
    public lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .secondarySystemBackground
        return tv
    }()
    
    public lazy var secondTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .secondarySystemBackground
        return tv
    }()
    
    public lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .systemOrange
        setupTextField()
        setupTextView()
        setupSecondTextView()
        setupButton()
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.15)])
    }
    
    private func setupTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4.5)])
    }
    
    private func setupSecondTextView() {
        addSubview(secondTextView)
        secondTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondTextView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            secondTextView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            secondTextView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            secondTextView.heightAnchor.constraint(equalTo: textView.heightAnchor)])
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: secondTextView.bottomAnchor, constant: 8),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalTo: secondTextView.widthAnchor, multiplier: 0.3)])
    }
    
}
