//
//  DetailScreenConfigurator.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/12/22.
//

import Foundation

final class DetailScreenConfigurator {
    static let shared = DetailScreenConfigurator()

    private init (){}

    func configure(with view: DetailScreenVC) {
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()
        let router = DetailScreenRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        router.dataSource = interactor
    }
}
