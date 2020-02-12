//
//  CreateViewController.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class CreateViewController: UIViewController {
    
    private let createView = CreateView()
    
    private let dataPersistence: DataPersistence<Card>
    
    init(_ dataPersistence: DataPersistence<Card>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createView.textField.delegate = self
        createView.textView.delegate = self
        createView.secondTextView.delegate = self
        createView.button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        if let text = createView.textField.text {
            let card = Card(cardTitle: text, facts: [createView.textView.text, createView.secondTextView.text])
            
            if !dataPersistence.hasItemBeenSaved(card) {
                
                do {
                    try dataPersistence.createItem(card)
                } catch {
                    present(UIAlertController.errorAlert("Error occurred creating card: \(error)"), animated: true)
                }
                
                createView.textField.text = nil
                createView.textView.text = ""
                createView.secondTextView.text = ""
                
                let alertVC = UIAlertController(title: "Success", message: "Successfully created a flashcard!", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertVC, animated: true, completion: nil)
                
            } else {
                
                present(UIAlertController.errorAlert("Card has already been saved."), animated: true)
            }
        }
    }
    
    private func checkFields() {
        if let text = createView.textField.text {
            if !createView.textView.text.trimmingCharacters(in: .whitespaces).isEmpty && !createView.secondTextView.text.trimmingCharacters(in: .whitespaces).isEmpty && !text.trimmingCharacters(in: .whitespaces).isEmpty {
                createView.button.isHidden = false
            } else {
                createView.button.isHidden = true
            }
        } else {
            createView.button.isHidden = true
        }
    }
    
}

extension CreateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkFields()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createView.textField.resignFirstResponder()
        return true
    }
}

extension CreateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        checkFields()
        return true
    }
}
