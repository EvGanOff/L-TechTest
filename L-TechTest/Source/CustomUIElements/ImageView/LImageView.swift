//
//  LImageView.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

class LImageView: UIImageView {

    let placeholderImage = Images.mainLogo
    //let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        tintColor = .blue
        layer.cornerRadius = 5
        clipsToBounds = true
        image = placeholderImage
    }

    func maskWith(color: UIColor) {
           guard let tempImage = image?.withRenderingMode(.alwaysTemplate) else { return }
           image = tempImage
           tintColor = color
       }
}
