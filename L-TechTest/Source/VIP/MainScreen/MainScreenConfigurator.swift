//
//  MainScreenConfigurator.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/12/22.
//

import Foundation

final class MainScreenConfigurator {
    static let shared = MainScreenConfigurator()

    private init (){}

    func configure(with view: MainScreenVC) {
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        router.dataSource = interactor
    }
}
