//
//  SearchViewController.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class SearchViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<Card>
    
    private let searchView = CardView()
    
    private let url = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
    
    private var cards = [Card]() {
        didSet {
            searchView.collectionView.reloadData()
        }
    }
    
    init(_ dataPersistence: DataPersistence<Card>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        searchView.collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "Card Cell")
        
        loadData()
    }
    
    private func loadData() {
        GenericCoderAPI.manager.getJSON(objectType: CardWrapper.self, with: url) { result in
            switch result {
            case.failure(let error):
                print(error)
            case .success(let wrapper):
                DispatchQueue.main.async {
                    self.cards = wrapper.cards
                }
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card Cell", for: indexPath) as? CardViewCell else {
            fatalError("Could not create a card view cell.")
        }
        cell.card = cards[indexPath.row]
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.configureView(cards[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardViewCell else {
            return
        }
        
        cell.animate()
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
}


extension SearchViewController: CardViewCellDelegate {
    func didPressButton(_ cell: CardViewCell, card: Card) {
        let alertvc = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.saveCard(card)
        }
        alertvc.addAction(cancelAction)
        alertvc.addAction(saveAction)
        present(alertvc, animated: true, completion: nil)
    }
    
    private func saveCard(_ card: Card) {
        do {
            try dataPersistence.createItem(card)
        } catch {
            print(error)
        }
        
        let alertVC = UIAlertController(title: "Success", message: "Successfully added a flashcard!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
