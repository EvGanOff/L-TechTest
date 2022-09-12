//
//  MainScreenRouter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

@objc protocol MainScreenRouterProtocol {
    func routeToDetailScreen()
}

protocol MainScreenDataSourceProtocol {
    var dataSource: MainScreenDataSource? { get }
}

final class MainScreenRouter: NSObject, MainScreenRouterProtocol, MainScreenDataSourceProtocol {

    weak var view: MainScreenVC?
    var dataSource: MainScreenDataSource?

    // MARK: - Routing -
    func routeToDetailScreen() {
        let mainVC = self.view
        let mainDS = self.dataSource
        let detailScreenVC = DetailScreenVC()
        var detailScreenDS = detailScreenVC.router?.dataSource
        self.passDataToDetailScreen(source: mainDS!, destination: &detailScreenDS!)
        self.navigateToDetailScreen(source: mainVC!, destination: detailScreenVC)
    }

    // MARK: - Navigation -
    func navigateToDetailScreen(source: MainScreenVC, destination: DetailScreenVC) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data -
    func passDataToDetailScreen(source: MainScreenDataSource, destination: inout DetailScreenDataSource) {
        guard let indexPath = view?.tableView.indexPathForSelectedRow else { return }
        destination.model = source.requestModels?[indexPath.row]
    }
}
