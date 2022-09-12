//
//  DetailScreenInteractor.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import Foundation

protocol DetailScreenInteractorProtocol {
    func provideDetailScreen()
}

protocol DetailScreenDataSource {
    var model: MainModel? { get set }
}

class DetailScreenInteractor: DetailScreenInteractorProtocol, DetailScreenDataSource {

    var presenter: DetailScreenPresenterProtocol?
    var worker: DetailScreenWorker?
    var model: MainModel?

    func provideDetailScreen() {
        worker = DetailScreenWorker()
        let imageData = worker?.getImage(from: model?.image)

        let response = DetailScreen.ShowDetails.Response(
            modelTitle: model?.title,
            modelText: model?.text,
            imageData: imageData
        )
        print(response.modelTitle ?? "ERROR")
        presenter?.presentScreenDetail(response: response)
    }
}
