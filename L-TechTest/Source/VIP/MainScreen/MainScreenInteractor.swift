//
//  MainScreenInteractor.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation
import UIKit

protocol MainScreenInteractorProtocol {
    func showInMainScreen()
    func reloadTableView()
    var  requestModels: [MainModel]? { get set }
    func updateSearchControl(with searchController: UISearchController)
    func sortByDate()
    func sortByServer()
}

protocol MainScreenDataSource {
    var requestModels: [MainModel]? { get set }
}

final class MainScreenInteractor: MainScreenInteractorProtocol, MainScreenDataSource {
    // MARK: - Properties -
    var requestModels: [MainModel]?
    var presenter: MainScreenPresenterProtocol?
    var worker = MainScreenWorker()
    var isSearching = false

    // MARK: - Metods MainScreenInteractorProtocol
    func showInMainScreen() {
        let response = MainScreen.ShowModels.Response(models: requestModels)
        presenter?.presentModels(response: response)
    }

    func updateSearchControl(with searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            worker.fetchModels { [weak self] models in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.requestModels = models
                    self.showInMainScreen()
                }
            }

            isSearching = false
            return
        }

        isSearching = true
        let filtredModel = requestModels?.filter{ $0.title?.lowercased().contains(filter.lowercased()) ?? false }
        self.requestModels = filtredModel
        self.showInMainScreen()
    }

    func reloadTableView() {
        requestModels?.removeAll()
        worker.fetchModels { [weak self] models in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.requestModels = models
                self.showInMainScreen()
            }
        }
    }

    func sortByDate() {
        guard requestModels != nil else { return }
        requestModels!.sort{$0.date! > $1.date!}
        self.showInMainScreen()
    }

    func sortByServer() {
        guard requestModels != nil else { return }
        requestModels!.sort{$0.sort! < $1.sort!}
        self.showInMainScreen()
    }
}
