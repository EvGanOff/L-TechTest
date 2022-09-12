//
//  DevExemModel.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

typealias ModelCellViewModel = MainScreen.ShowModels.ViewModel.ModelCellViewModel

protocol CellIdentifiable {
    var cellIdentifier: String { get }
}

enum MainScreen {

    // MARK: Use cases
    enum ShowModels {
        struct Response {
            let models: [MainModel]?
        }

        struct ViewModel {
            struct ModelCellViewModel: CellIdentifiable {
                var title: String?
                var text: String?
                var date: String?
                var imageString: String?
                var cellIdentifier: String {
                    MainScreenCustomCell.reuseID
                }

                init(detailScreenModel: MainModel) {
                    title = detailScreenModel.title
                    text = detailScreenModel.text
                    date = detailScreenModel.date?.convertToMonthYearFormat()
                    imageString = detailScreenModel.image
                }
            }

            let rows: [CellIdentifiable]
        }
    }
}

