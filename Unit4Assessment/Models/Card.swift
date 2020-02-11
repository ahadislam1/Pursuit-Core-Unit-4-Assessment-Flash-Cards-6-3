//
//  Flashcard.swift
//  unit4assessment
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

// MARK: - Flashcards
struct CardWrapper: Codable {
    let cardListType: String
    let apiVersion: String
    let cards: [Card]

    enum CodingKeys: String, CodingKey {
        case cardListType = "cardListType"
        case apiVersion = "apiVersion"
        case cards = "cards"
    }
}

// MARK: - Card
struct Card: Codable, Equatable {
    let cardTitle: String
    let facts: [String]

    enum CodingKeys: String, CodingKey {
        case cardTitle = "cardTitle"
        case facts = "facts"
    }
}
