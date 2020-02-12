//
//  UIAlertActionController+Error.swift
//  unit4assessmentTests
//
//  Created by Ahad Islam on 2/12/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

extension UIAlertController {
    public static func errorAlert(_ body: String) -> UIAlertController {
        let alertvc = UIAlertController(title: "Error", message: body, preferredStyle: .alert)
        alertvc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertvc
    }
}
