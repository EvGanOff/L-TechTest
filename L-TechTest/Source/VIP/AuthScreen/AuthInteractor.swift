//
//  AuthInteractor.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

protocol AuthoIteractorProtocol {
    func startSettings()
    func checkUser(request: AuthModel.checkUser.Request)
    func fetchModels()
}

protocol AuthDataStore {
    var models: [MainModel]? { get set }
    var maskNumber: MaskNumberModel? { get set }
}

final class AuthInteractor: AuthDataStore, AuthoIteractorProtocol {
    var maskNumber: MaskNumberModel?
    var models: [MainModel]? = []
    var presenter: AuthPresenterProtocol?
    var worker = AuthoWorker()

    let networkManager = NetworkManager()

    func startSettings() {
        guard let user = KeychainManager.standard.read(service: "access-user", account: "test", type: KeyChainModel.self) else {
            networkManager.getMaskNumber(completion: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let response = AuthModel.getMaskNumber.Response(maskNumber: data, error: nil)
                        self.presenter?.showMaskNumber(response: response)
                    case .failure(_):
                        let response = AuthModel.getMaskNumber.Response(maskNumber: nil, error: .invaliedData)
                        self.presenter?.showErrorMaskNumberAlert(response: response)
                    }
                }
            })
            return
        }

        let response = AuthModel.fetchUser.Response(user: user)
        presenter?.showUser(response: response)
    }

    func checkUser(request: AuthModel.checkUser.Request) {
        let number = request.number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let password = request.password
        let maskNumber = request.maskNumber
        let request = AuthModel.checkUser.Request(number: number, password: password, maskNumber: maskNumber)
        let userData = UserModel(phone: request.number, password: request.password)

        NetworkManager.shared.authorize(userModel: userData) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let bool):
                    if bool {
                        let user = KeyChainModel(number: number, password: password, maskNumber: maskNumber)
                        KeychainManager.standard.save(user, service: "access-user", account: "test")
                        self.fetchModels()
                        print("user saved in KeyChain")
                    } else {
                        let response = AuthModel.checkUser.Response(error: .invalidateAuth)
                        self.presenter?.showErrorReviewUserAlert(response: response)
                    }
                case .failure(let error):
                    let response = AuthModel.checkUser.Response(error: error)
                    self.presenter?.showErrorReviewUserAlert(response: response)
                }
            }
        }
    }

    func fetchModels() {
        worker.fetchModels { [weak self] models in
            guard let self = self else { return }
            self.models = models
            self.presenter?.presentMainScreenVC()
        }
    }
}


