//
//  AuthRouter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

@objc protocol AuthRouterProtocol {
    func routeToMainScreen()
}

protocol AuthoDataSource {
    var dataSource: AuthDataStore? { get }
}

final class AuthRouter: NSObject, AuthRouterProtocol, AuthoDataSource {

    weak var view: AuthVC?
    var dataSource: AuthDataStore?

    // MARK: - Routing -
    func routeToMainScreen() {
        let startVC = view
        let startDS = dataSource
        let mainScreenVC = MainScreenVC()
        mainScreenVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        var mainScreenDS = mainScreenVC.router?.dataSource
        passDataToMainScreen(source: startDS!, destination: &mainScreenDS!)
        navigateToMainScreen(source: startVC!, destination: mainScreenVC)
    }

    // MARK: - Navigation -
    func navigateToMainScreen(source: AuthVC, destination: MainScreenVC) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data -
    func passDataToMainScreen(source: AuthDataStore, destination: inout MainScreenDataSource) {
        destination.requestModels = source.models
    }
}
