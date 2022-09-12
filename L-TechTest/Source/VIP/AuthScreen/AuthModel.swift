//
//  AuthModel.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

enum AuthModel {

    enum fetchUser {
        struct Response {
            var user: KeyChainModel?
        }

        struct ViewModel {
            var number: String
            var password: String
            var maskNumber: String
            var maskNumberModel: MaskNumberModel
        }
    }

    enum getMaskNumber {
        struct Response {
            var maskNumber: MaskNumberModel?
            var error: LError?
        }

        struct ViewModel {
            var maskNumberModel: MaskNumberModel
            var error: String
        }
    }

    enum fetchModels {
        struct Request {
            var models: [MainModel]?
        }

        struct Response {
            var models: [MainModel]?
        }

        struct ViewModel {
            var models: [MainModel]
        }
    }

    enum saveUser {
        struct Request {
            var number: String
            var password: String
            var maskNumber: MaskNumberModel
        }
    }

    enum checkUser {
        struct Request {
            var number: String
            var password: String
            var maskNumber: MaskNumberModel
        }

        struct Response {
            var error: LError?
        }

        struct ViewModel {
            var error: String
        }
    }
}
