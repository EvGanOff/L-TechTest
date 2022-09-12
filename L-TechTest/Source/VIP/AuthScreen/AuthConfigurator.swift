//
//  AuthConfigurator.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

final class AuthConfigurator {
    static let shared = AuthConfigurator()

    private init (){}

    func configure(with view: AuthVC) {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        router.dataSource = interactor
    }
}
