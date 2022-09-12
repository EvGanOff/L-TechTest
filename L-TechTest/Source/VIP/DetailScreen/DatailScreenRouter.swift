//
//  DatailScreenRouter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import UIKit

protocol DetailScreenDataSourceProtocol {
    var dataSource: DetailScreenDataSource? { get }
}

final class DetailScreenRouter: DetailScreenDataSourceProtocol {
    weak var view: DetailScreenVC?
    var dataSource: DetailScreenDataSource?
}
