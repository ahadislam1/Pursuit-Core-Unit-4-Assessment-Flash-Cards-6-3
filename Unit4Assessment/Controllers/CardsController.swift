//
//  CardsController.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class CardsController: UITabBarController {
    
    private var dataPersistence = DataPersistence<Card>(filename: "savedCards.plist")
    
    private lazy var cardVC: CardViewController = {
        let vc = CardViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "questionmark.circle"), tag: 0)
        return vc
    }()
    
    private lazy var createVC: CreateViewController = {
        let vc = CreateViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        return vc
    }()
    
    private lazy var searchVC: SearchViewController = {
        let vc = SearchViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [cardVC, createVC, searchVC]
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
