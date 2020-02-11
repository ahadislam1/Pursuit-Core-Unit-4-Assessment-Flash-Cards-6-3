//
//  CardViewCell.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

protocol CardViewCellDelegate: AnyObject {
    func didPressButton(_ cell: CardViewCell, card: Card)
}

class CardViewCell: UICollectionViewCell {
    
    private lazy var button: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.text = "Title"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    private lazy var textView: UILabel = {
        let tv = UILabel()
        tv.alpha = 0
        tv.text = "OK"
        tv.numberOfLines = 0
        tv.font = UIFont.preferredFont(forTextStyle: .caption1)
        return tv
    }()
    
    public var card: Card!
    
    public weak var delegate: CardViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // TODO: Rewrite bool parameter to enum.
    public func configureView(_ card: Card, cardView: Bool = false) {
        titleLabel.text = card.cardTitle
        textView.text = card.facts.joined(separator: "\n")
        
        if cardView {
            button.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
        }
    }
    
    public func animate() {
        if titleLabel.alpha == 1 {
            UIView.transition(with: self, duration: 2, options: .transitionFlipFromLeft, animations: {
                self.titleLabel.alpha = 0
                self.textView.alpha = 1
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 2, options: .transitionFlipFromRight, animations: {
                self.titleLabel.alpha = 1
                self.textView.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegate?.didPressButton(self, card: card)
    }
    
    
    private func commonInit() {
        backgroundColor = .systemGray
        
        setupButton()
        setupTitleLabel()
        setupTextView()
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func setupTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: button.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }
}
