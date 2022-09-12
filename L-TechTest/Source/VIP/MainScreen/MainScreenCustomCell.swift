//
//  MainScreenCustomCell.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import UIKit
import SnapKit
import SDWebImage

final class MainScreenCustomCell: UITableViewCell {

    static let reuseID = "MainScreenCustomCell"

    // MARK: - Properties -
    private let mainTitle = LTitleLabel(textAligment: .left, fontSize: 20)
    private let detailTitle = LBodyLabel(textAligment: .left)
    private let dateTitle = LSecondaryTitleLabel(fontSize: 10)
    private lazy var image = UIImageView()

    var cellModel: CellIdentifiable? {
        didSet {
            set()
        }
    }

    private func set() {
        guard let cellModel = cellModel as? ModelCellViewModel else { return }

        let photoURL = cellModel.imageString
        guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
        self.image.sd_setImage(with: url, completed: nil)

        self.mainTitle.text = cellModel.title
        self.detailTitle.text = cellModel.text

        guard let date = cellModel.date else { return }
        self.dateTitle.text = date
    }

    // MARK: - Initializers -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        setupHierarchy()
        setupLayout()
    }

    private func configureImageView() {
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupHierarchy -
    private func setupHierarchy() {
        [image, mainTitle, detailTitle, dateTitle].forEach { contentView.addSubview($0) }
    }

    // MARK: - SetupLayout -
    private func setupLayout() {
        image.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(Constant.leadingTralingAncor)
            $0.top.equalTo(contentView.snp.top).offset(Constant.topAnchor)
            $0.height.width.equalTo(Constant.heightWidthImageView)
        }

        mainTitle.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(Constant.topAnchor)
            $0.leading.equalTo(image.snp.trailing).offset(Constant.leadingTralingAncor)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-Constant.leadingTralingAncor)

        }

        detailTitle.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(Constant.topAnchor)
            $0.leading.equalTo(mainTitle.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-Constant.leadingTralingAncor)
        }

        dateTitle.snp.makeConstraints {
            $0.top.equalTo(detailTitle.snp.bottom).offset(Constant.topAnchor)
            $0.leading.equalTo(detailTitle.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-Constant.leadingTralingAncor)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-Constant.bottomAnchor * 1.5)
        }
    }

    // MARK: - Constats and Metrics -
    private enum Constant {
        static let topAnchor: CGFloat = 16
        static let leadingTralingAncor: CGFloat = 16
        static let bottomAnchor: CGFloat = 16
        static let heightWidthImageView = 100
    }

    // MARK: - Prepare For Reuse -
    override func prepareForReuse() {
        self.mainTitle.text = nil
        self.detailTitle.text = nil
        self.dateTitle.text = nil
        self.image.image = nil
    }
}
