//
//  MainScreenPresenter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

protocol MainScreenPresenterProtocol {
    func presentModels(response: MainScreen.ShowModels.Response)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var view: MainScreenViewProtocol?

    func presentModels(response: MainScreen.ShowModels.Response) {
        var rows: [ModelCellViewModel] = []
        response.models?.forEach({ model in
            rows.append(ModelCellViewModel(detailScreenModel: model))
        })
        
        let viewModel = MainScreen.ShowModels.ViewModel(rows: rows)
        view?.mainScreenModels(viewModel: viewModel)
    }
}
