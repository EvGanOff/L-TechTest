//
//  DetailScreenPresenter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import Foundation

protocol DetailScreenPresenterProtocol {
    func presentScreenDetail(response: DetailScreen.ShowDetails.Response)
}

class DetailScreenPresenter: DetailScreenPresenterProtocol {

    weak var view: DetailScreenVCProtocol?

    func presentScreenDetail(response: DetailScreen.ShowDetails.Response) {

        let viewModel = DetailScreen.ShowDetails.ViewModel(
            modelTitle: response.modelTitle ?? "",
            modelText: response.modelText ?? "",
            imageData: response.imageData ?? "ERROR".data(using: .utf8) ?? Data()
        )
        view?.displayDetailScreen(viewModel: viewModel)
    }
}
