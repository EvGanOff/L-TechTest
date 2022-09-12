//
//  MainModel.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import Foundation

struct MainModel: Decodable {
    var id: String?
    var title, text: String?
    var image: String?
    var sort: Int?
    var date: Date?

    init(mainModel: MainModel) {
        self.id = mainModel.id
        self.title = mainModel.title
        self.text = mainModel.text
        self.image = "http://dev-exam.l-tech.ru\(mainModel.image ?? "")"
        self.sort = mainModel.sort
        self.date = mainModel.date
    }
}
