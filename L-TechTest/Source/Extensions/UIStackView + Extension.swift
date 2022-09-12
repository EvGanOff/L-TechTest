//
//  UIStackView + Extension.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

extension UIStackView {
    func verticalAxisStack() {
        axis = .vertical
        spacing = 10
        layer.cornerRadius = 10
        distribution = .fillEqually
        layoutMargins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func horizontalAxisStack() {
        axis = .horizontal
        spacing = 20
        layer.cornerRadius = 10
        layer.borderWidth = 0.3
        distribution = .fillEqually
        layoutMargins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
