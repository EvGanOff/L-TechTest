//
//  MainScreenVC.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import UIKit
import SnapKit

protocol MainScreenViewProtocol: AnyObject {
    func mainScreenModels(viewModel: MainScreen.ShowModels.ViewModel)
}

final class MainScreenVC: UIViewController {

    // MARK: - Properties -
    lazy var tableView = UITableView()
    private var segmentedControl = UISegmentedControl()
    private let networkManager = NetworkManager.shared
    private var rows: [CellIdentifiable] = []
    var interactor: MainScreenInteractorProtocol?
    var router: (NSObjectProtocol & MainScreenRouterProtocol & MainScreenDataSourceProtocol)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureTableView()
        configureSegmentCotrol()
        configureSearchController()
        setupHierarchy()
        setupLayout()
        configureNavigationBar()
        interactor?.showInMainScreen()
    }

    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func actionSegmentControl(with segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            interactor?.sortByServer()
        case 1:
            interactor?.sortByDate()
        default:
            interactor?.sortByServer()
        }
    }

    @objc func logOutTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func reloadData() {
        interactor?.reloadTableView()
    }

    private func configureNavigationBar() {
        title = "DevExam"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
    }

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MainScreenConfigurator.shared.configure(with: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainScreenCustomCell.self, forCellReuseIdentifier: MainScreenCustomCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .clear
        tableView.layer.borderColor = UIColor.black.cgColor
    }

    private func configureSegmentCotrol() {
        segmentedControl = UISegmentedControl(items: ["Сортировка сервера", "Сортировка по дате"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .white
        segmentedControl.layer.masksToBounds = true
        segmentedControl.layer.cornerRadius = 12
        segmentedControl.addTarget(self, action: #selector(actionSegmentControl), for: .valueChanged)
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    // MARK: - SetupHierarchy -
    private func setupHierarchy() {
        [segmentedControl, tableView].forEach { view.addSubview($0) }
    }

    // MARK: - SetupLayout -
    private func setupLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.topAnchor)
            make.leading.equalTo(view.snp.leading).offset(Constants.leadingTrailingSegmentControlAnchor)
            make.trailing.equalTo(view.snp.trailing).offset(-Constants.leadingTrailingSegmentControlAnchor)
            make.height.equalTo(Constants.heightSegmentControlAnchor)

        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(Constants.topAnchor * 1.5)
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Constats and Metrics -
    private enum Constants {
        static let topAnchor: CGFloat = 12
        static let leadingTrailingSegmentControlAnchor: CGFloat = 24
        static let heightSegmentControlAnchor: CGFloat = 50
    }
}

// MARK: - Extension UITableViewDelegate -
extension MainScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetailScreen()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension UITableViewDataSource -
extension MainScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath) as? MainScreenCustomCell else { return UITableViewCell()}
        cell.cellModel = cellViewModel
        return cell
    }
}

extension MainScreenVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        interactor?.updateSearchControl(with: searchController)
    }
}

extension MainScreenVC: MainScreenViewProtocol {
    func mainScreenModels(viewModel: MainScreen.ShowModels.ViewModel) {
        rows = viewModel.rows
        tableView.reloadData()
    }
}
