//
//  UIView + Extention.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/12/22.
//

import UIKit
import SnapKit

extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        snp.makeConstraints {
            $0.top.equalTo(superview.snp.top)
            $0.leading.equalTo(superview.snp.leading)
            $0.trailing.equalTo(superview.snp.trailing)
            $0.bottom.equalTo(superview.snp.bottom)
        }
    }

    func transformButton() {
        UIView.animate(withDuration: 0.9, animations: {
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { _ in
            UIView.animate(withDuration: 0.9) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
