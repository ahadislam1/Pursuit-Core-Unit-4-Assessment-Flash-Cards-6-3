//
//  CardViewController.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class CardViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<Card>
    
    private let cardView = CardView()
    
    private var cards = [Card]() {
        didSet {
            cardView.collectionView.reloadData()
            if cards.isEmpty {
                cardView.collectionView.backgroundView = EmptyView("Flashcards", message: "Currently there are no flashcards, try making one, or adding one from the network.")
            } else {
                cardView.collectionView.backgroundView = nil
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Card>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadCards() {
        do {
            cards = try dataPersistence.loadItems()
        } catch {
            present(UIAlertController.errorAlert("Error occurred loading cards: \(error)"), animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataPersistence.delegate = self
        cardView.collectionView.delegate = self
        cardView.collectionView.dataSource = self
        cardView.collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "Card Cell")
        loadCards()
    }
}


extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card Cell", for: indexPath) as? CardViewCell else {
            fatalError("Could not create card cell.")
        }
        cell.backgroundColor = .tertiarySystemFill
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.systemTeal.cgColor
        cell.clipsToBounds = true
        cell.configureView(cards[indexPath.row], cardView: true)
        cell.card = cards[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardViewCell {
            cell.animate()
        }
    }
    
    
}

extension CardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
    }
}

extension CardViewController: CardViewCellDelegate {
    func didPressButton(_ cell: CardViewCell, card: Card) {
        let alertvc = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteCard(card)
        }
        alertvc.addAction(cancelAction)
        alertvc.addAction(deleteAction)
        present(alertvc, animated: true, completion: nil)
    }
    
    private func deleteCard(_ card: Card) {
        guard let index = cards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            present(UIAlertController.errorAlert("error deleting card: \(error)"), animated: true)
        }
    }
}

extension CardViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCards()
    }
}
