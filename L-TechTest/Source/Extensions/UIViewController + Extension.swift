//
//  UIAlert + Extension.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

extension UIViewController {
    func presentsAlertController(title: String, massage: String, buttonTitle: String) {
        let alertVC = LAlertViewController(title: title, massage: massage, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }

    func hidenKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
