//
//  AuthVC.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    func showUser(viewModel: AuthModel.fetchUser.ViewModel)
    func showPhoneMask(viewModel: AuthModel.getMaskNumber.ViewModel)
    func showErrorMaskNumberAlert(viewModel: AuthModel.getMaskNumber.ViewModel)
    func showErrorCheckUserAlert(viewModel: AuthModel.checkUser.ViewModel)
    func presentMainScreenVC()
}

final class AuthVC: UIViewController {

    // MARK: - Properties -
    private let logo = LImageView(frame: .zero)
    private let numberTextField = LTextField(placeholder: "Введите номер телефона", isPassword: false)
    private let passwordTextField = LTextField(placeholder: "Ввведите пароль", isPassword: true)
    private let actionButton = LButton(backgraundColor: .blue, title: "Поехали!")
    private let textFieldStack = UIStackView()

    private var maskNumber: MaskNumberModel?
    var interactor: AuthoIteractorProtocol?
    var router: (NSObjectProtocol & AuthRouterProtocol & AuthoDataSource)?

    // MARK: - LifeCircle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.hidenKeyboardWhenTappedAround()
        AuthConfigurator.shared.configure(with: self)
        setupHierarchy()
        configureTextFieldStack()
        configureLogoImageView()
        configureActionButton()
        configureUserNameTextField()
        interactor?.startSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Metods -
    private func configureTextFieldStack() {
        textFieldStack.verticalAxisStack()
        textFieldStack.spacing = 20
    }

    @objc func pushToMainScreenViewConrolller() {
        guard let number = numberTextField.text, number != "",
              let password = passwordTextField.text, password != ""  else {
            presentsAlertController(title: "Пожалуйста", massage: "Заполните поля ввода!", buttonTitle: "Ок")
            return
        }
        numberTextField.delegate = self
        numberTextField.keyboardType = .numberPad

        let requestToCheckUser = AuthModel.checkUser.Request(number: number, password: password, maskNumber: maskNumber ?? MaskNumberModel(phoneMask: ""))
        interactor?.checkUser(request: requestToCheckUser)
    }

    // MARK: - SetupHierarchy -
    private func setupHierarchy() {
        [logo, textFieldStack, actionButton].forEach { view.addSubview($0) }
    }

    // MARK: - ConfigureViews -
    private func configureLogoImageView() {
        logo.image = Images.mainLogo

        logo.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(Constats.logoImageViewTopAnchor)
            make.centerX.equalToSuperview()
            make.leading.equalTo(Constats.logoImageViewPaddingAnchor)
            make.trailing.equalTo(-Constats.logoImageViewPaddingAnchor)
            make.height.equalTo(Constats.logoImageViewHeightAnchor)
        }
    }

    private func configureUserNameTextField() {
        numberTextField.delegate = self
        [numberTextField, passwordTextField].forEach {
            textFieldStack.addArrangedSubview($0)
        }

        textFieldStack.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(Constats.textFieldStackViewTopAnchor)
            make.leading.equalTo(logo.snp.leading)
            make.trailing.equalTo(logo.snp.trailing)
            make.height.equalTo(Constats.textFieldStackViewHeightAnchor)
        }
    }

    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(pushToMainScreenViewConrolller), for: .touchUpInside)

        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Constats.actionButtonBottomAnchor)
            make.leading.equalTo(view.snp.leading).offset(Constats.actionButtonLeadingAnchor)
            make.trailing.equalTo(view.snp.trailing).offset(Constats.actionButtonTrailingAnchor)
            make.height.equalTo(Constats.actionButtonHeightAnchor)
        }
    }
}

// MARK: - AuthViewProtocol -
extension AuthVC: AuthViewProtocol {
    func showUser(viewModel: AuthModel.fetchUser.ViewModel) {
        maskNumber = viewModel.maskNumberModel
        numberTextField.text = viewModel.number
        passwordTextField.text = viewModel.password
    }

    func showPhoneMask(viewModel: AuthModel.getMaskNumber.ViewModel) {
        maskNumber = viewModel.maskNumberModel
        numberTextField.placeholder = viewModel.maskNumberModel.phoneMask
    }

    func showErrorMaskNumberAlert(viewModel: AuthModel.getMaskNumber.ViewModel) {
        presentsAlertController(title: "Ошибка", massage: viewModel.error, buttonTitle: "ОК")
    }

    func showErrorCheckUserAlert(viewModel: AuthModel.checkUser.ViewModel) {
        presentsAlertController(title: "Ошибка", massage: viewModel.error, buttonTitle: "ОК")
    }

    func presentMainScreenVC() {
        router?.routeToMainScreen()
    }
}

// MARK: - UITextFieldDelegate -
extension AuthVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullstring = (textField.text ?? "") + string
        textField.text = .format(phonenumber: fullstring, maskNumber: maskNumber, shouldRemoveLastDigit: range.length == 1, range: range)

        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Constats and Metrics -
private struct Constats {
    static let logoImageViewTopAnchor: CGFloat = 150
    static let logoImageViewHeightAnchor: CGFloat = 70
    static let logoImageViewPaddingAnchor: CGFloat = 24

    static let textFieldStackViewTopAnchor: CGFloat = 50
    static let textFieldStackViewHeightAnchor: CGFloat = 120

    static let actionButtonBottomAnchor: CGFloat = -50
    static let actionButtonLeadingAnchor: CGFloat = 50
    static let actionButtonTrailingAnchor: CGFloat = -50
    static let actionButtonHeightAnchor: CGFloat = 50
}
