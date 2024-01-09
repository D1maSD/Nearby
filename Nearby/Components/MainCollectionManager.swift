//
//  MainCollectionManager.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//

import UIKit
//import UseCases

protocol MainCollectionManagerDelegate: AnyObject {
    func selectCell(category: CategoryModel)
    func selectCell(item: MenuItem, value: Int)
}

protocol MainCollectionManagment: AnyObject {
    var delegate: MainCollectionManagerDelegate? { get set }
    var id: Int { get set }
    func attach(_ collectionView: UICollectionView, id: Int)
    func update(configurators: [MainCategoriesCollectionConfigurator])
}

final class MainCollectionManager: NSObject, MainCollectionManagment {
    weak var delegate: MainCollectionManagerDelegate?
    var id = Int()
    var menuItems = [MenuItem]()
    private var collectionView: UICollectionView!
    private var configurators = [MainCategoriesCollectionConfigurator]()

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 13
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()

    func attach(_ collectionView: UICollectionView, id: Int) {
            AuthService.shared.getMenuItems(forLocationID: id) { result in
                switch result {
                case .success(let menuItems):
                    DispatchQueue.main.async {
                        self.menuItems = menuItems
                        collectionView.register(cellType: MainCategoriesCollectionCell.self)
                        collectionView.setCollectionViewLayout(self.flowLayout, animated: false)
                        collectionView.delegate = self
                        collectionView.dataSource = self
                        collectionView.backgroundColor = .clear
                        self.collectionView = collectionView
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }


    func loadImage(imageURL: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let imageURLString = imageURL, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    print("Не удалось создать изображение из полученных данных.")
                }
            }.resume()
        } else {
            print("Недопустимый URL изображения.")
        }
    }


    func update(configurators: [MainCategoriesCollectionConfigurator]) {
        self.configurators = configurators
       
    }
}

// MARK: - DataSource

extension MainCollectionManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainCategoriesCollectionCell.self)
        cell.delegate = self
        cell.priceLabel.text = String("\(menuItems[indexPath.row].price) руб")
        cell.title.text = menuItems[indexPath.row].name

        loadImage(imageURL: menuItems[indexPath.row].imageURL) { result in
            switch result {
            case .success(let success):
                cell.imageView.image = success
            case .failure(_):
                cell.imageView.image = UIImage(named: "contacts")
            }
        }
        return cell
    }
}

// MARK: - Delegate

extension MainCollectionManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let availableHeight = height - spacing * 3
        let itemWidthDimension = floor(availableWidth / numberOfItemsPerRow)
        let itemHeightDimension = floor(availableHeight / 3)
        return CGSize(width: itemWidthDimension - 3, height: itemHeightDimension - 9)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configurators[indexPath.row]
        delegate?.selectCell(category: configurator.model)
    }
}


final class MainCategoriesCollectionConfigurator {
    private(set) var model: CategoryModel

    func setupCell(_ cell: UIView) {
        guard let cell = cell as? MainCategoriesCollectionCell else { return }
        cell.setup(image: "model.image.urlString", titleText: "model.title")
    }

    init(model: CategoryModel) {
        self.model = model
    }
}




final class MainCategoriesCollectionCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addShadowToCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private var plusImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusOne"), for: .normal)
        return button
    }()

    private let minusImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusTwo"), for: .normal)
        return button
    }()

     let whiteView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#AF9479")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.light16Font
        label.text = "Эспрессо"
        label.textAlignment = .left
        return label
    }()
    private let valueTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.regular16Font
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.semibold16Font
        label.text = "200 руб"
        label.textAlignment = .left
        return label
    }()

    func setup(image: String, titleText: String) {
        imageView.image = UIImage(named: "contacts")
        title.text = titleText
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
        setupUI()

    }

    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        setupImageView()
        imageView.image = UIImage(named: "cover3")
        setupTitle()
        setupWhiteView()
        plusImageButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusImageButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
        contentView.addSubview(whiteView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(whiteView.snp.top)
            
        }
    }
    private func setupWhiteView() {
        whiteView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    private func setupTitle() {
        whiteView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }

        whiteView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
        }

        whiteView.addSubview(plusImageButton)
        plusImageButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(12)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
        whiteView.addSubview(minusImageButton)
        minusImageButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-70)
            make.height.equalTo(12)
            make.width.equalTo(12)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }

        whiteView.addSubview(valueTitle)
        valueTitle.snp.makeConstraints { make in
            make.left.equalTo(minusImageButton.snp.right).offset(3)
            make.right.equalTo(plusImageButton.snp.left).offset(-3)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
    }
    private func addShadowToCell() {
        layer.cornerRadius = 6
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0.2, height: 2)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 1.5
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
    }

    var value: Int = 0 {
        didSet {
            valueTitle.text = "\(value)"
        }
    }

    weak var delegate: MainCategoriesCollectionCellDelegate?

    @objc func plusButtonTapped() {
        value += 1
        delegate?.plusButtonTapped(for: self, value: value)
    }

    @objc func minusButtonTapped() {
        value -= 1
            delegate?.minusButtonTapped(for: self, value: value)
    }
}

public class CategoryModel {
    public let id: Int
    public let title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

protocol MainCategoriesCollectionCellDelegate: AnyObject {
    func plusButtonTapped(for cell: MainCategoriesCollectionCell, value: Int)
    func minusButtonTapped(for cell: MainCategoriesCollectionCell, value: Int)
}

extension MainCollectionManager : MainCategoriesCollectionCellDelegate  {
    func plusButtonTapped(for cell: MainCategoriesCollectionCell, value: Int) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
            let menuItem = menuItems[indexPath.row]

        delegate?.selectCell(item: menuItem, value: value)
    }

    func minusButtonTapped(for cell: MainCategoriesCollectionCell, value: Int) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let menuItem = menuItems[indexPath.row]
    delegate?.selectCell(item: menuItem, value: value)

    }
}
