//
//  File.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

extension UITextField {

    convenience init (placeholder: String = "", isPassword: Bool = false) {
        self.init()
        self.placeholder = placeholder
        layer.masksToBounds = true

        if isPassword {
            isSecureTextEntry = true
            clearButtonMode = .whileEditing
        }
    }
}
