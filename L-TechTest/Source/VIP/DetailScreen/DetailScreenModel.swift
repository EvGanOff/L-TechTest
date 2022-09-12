//
//  DetailScreenModel.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import Foundation

enum DetailScreen {
    enum ShowDetails {
        struct Response {
            let modelTitle: String?
            let modelText: String?
            let imageData: Data?
        }

        struct ViewModel {
            let modelTitle: String
            let modelText: String
            let imageData: Data
        }
    }
}
