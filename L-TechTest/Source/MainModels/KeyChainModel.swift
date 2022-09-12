//
//  KeyChainModel.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

struct KeyChainModel: Codable {
    var number: String?
    var password: String?
    var maskNumber: MaskNumberModel?
}
