//
//  DetailScreenVC.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import UIKit
import SnapKit

protocol DetailScreenVCProtocol: AnyObject {
    func displayDetailScreen(viewModel: DetailScreen.ShowDetails.ViewModel)
}

final class DetailScreenVC: UIViewController {

    // MARK: - Properties -

    private lazy var scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var stackView = UIStackView()
    private lazy var imageView = LImageView(frame: .zero)

    private lazy var titleLabel = LTitleLabel(textAligment: .center, fontSize: 32)
    private lazy var textLabel = LBodyLabel(textAligment: .center)
    var interactor: DetailScreenInteractorProtocol?
    var router: DetailScreenDataSourceProtocol?

    // MARK: Viewlifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureScrollView()
        configureUIElements()
        interactor?.provideDetailScreen()
    }

    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        stackView.verticalAxisStack()
        [imageView, titleLabel, textLabel, textLabel].forEach { stackView.addSubview($0) }

        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(600)
        }
    }

    // MARK: - Lifecycle -
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        DetailScreenConfigurator.shared.configure(with: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Detail Screen"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - ConfigureUIElements -
    private func configureUIElements() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Costants.stackViewTopAnchor)
            make.leading.equalTo(contentView.snp.leading).offset(Costants.padding)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Costants.padding)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-Costants.padding * 2)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top).offset(Costants.topAnchorImageViewTextLabel)
            make.leading.equalTo(stackView.snp.leading).offset(Costants.padding)
            make.trailing.equalTo(stackView.snp.trailing).offset(-Costants.padding)
            make.height.equalTo(Costants.heightImageView)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Costants.topAnchorImageViewTextLabel * 2)
            make.leading.equalTo(imageView.snp.leading).offset(Costants.padding * 2)
            make.trailing.equalTo(imageView.snp.trailing).offset(-Costants.padding * 2)
        }

        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Costants.topAnchorImageViewTextLabel)
            make.leading.equalTo(imageView.snp.leading).offset(Costants.padding * 2)
            make.trailing.equalTo(imageView.snp.trailing).offset(-Costants.padding * 2)
        }
    }

    private enum Costants {
        static let stackViewTopAnchor: CGFloat = 50
        static let padding: CGFloat = 12
        static let topAnchorImageViewTextLabel: CGFloat = 12
        static let heightImageView: CGFloat = 300
    }
}

extension DetailScreenVC: DetailScreenVCProtocol {
    func displayDetailScreen(viewModel: DetailScreen.ShowDetails.ViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.modelTitle
            self.textLabel.text = viewModel.modelText
            self.imageView.image = UIImage(data: viewModel.imageData)
        }
    }
}
