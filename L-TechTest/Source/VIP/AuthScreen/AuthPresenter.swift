//
//  AuthPresenter.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

protocol AuthPresenterProtocol {
    func showUser(response: AuthModel.fetchUser.Response)
    func showMaskNumber(response: AuthModel.getMaskNumber.Response)
    
    func showErrorReviewUserAlert(response: AuthModel.checkUser.Response)
    func showErrorMaskNumberAlert(response:AuthModel.getMaskNumber.Response)

    func presentMainScreenVC()
}

final class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?

    func showMaskNumber(response: AuthModel.getMaskNumber.Response) {
        let maskNumber = MaskNumberModel(phoneMask: response.maskNumber?.phoneMask ?? "")
        let viewModel = AuthModel.getMaskNumber.ViewModel(maskNumberModel: maskNumber, error: "EROR")
        view?.showPhoneMask(viewModel: viewModel)
    }

    func showErrorMaskNumberAlert(response: AuthModel.getMaskNumber.Response) {
        let errorResponse = response.error?.localizedDescription ?? "Попробуйте перезапустить приложение"
        let viewModel = AuthModel.getMaskNumber.ViewModel(maskNumberModel: response.maskNumber ?? MaskNumberModel(phoneMask: "") , error: errorResponse)
        view?.showErrorMaskNumberAlert(viewModel: viewModel)
    }

    func showErrorReviewUserAlert(response: AuthModel.checkUser.Response) {
        let response = response.error?.localizedDescription ?? "Произошла ошибка"
        let viewModel = AuthModel.checkUser.ViewModel(error: response)
        view?.showErrorCheckUserAlert(viewModel: viewModel)
    }

    func showUser(response: AuthModel.fetchUser.Response) {
        let viewModel = AuthModel.fetchUser.ViewModel(number: .format(phonenumber: response.user?.number ?? "", maskNumber:response.user?.maskNumber ?? MaskNumberModel(phoneMask: "")),

        password: response.user?.password ?? "", maskNumber: response.user?.maskNumber?.phoneMask ?? "",
        maskNumberModel: response.user?.maskNumber ?? MaskNumberModel(phoneMask: ""))

        view?.showUser(viewModel: viewModel)
    }

    func presentMainScreenVC() {
        view?.presentMainScreenVC()
    }
}
