//
//  unit4assessmentTests.swift
//  unit4assessmentTests
//
//  Created by Ahad Islam on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import XCTest
@testable import unit4assessment

class unit4assessmentTests: XCTestCase {
    
    private func testEndpointJSON() {
        let url = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        var cards = [Card]()
        let exp = XCTestExpectation(description: "Attempted to create a model from JSON url.")
        
        GenericCoderAPI.manager.getJSON(objectType: CardWrapper.self, with: url) { result in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let wrapper):
                cards = wrapper.cards
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5)
    }

}
