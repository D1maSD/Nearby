//
//  NearestPlacesViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//

import UIKit

final class NearestPlacesViewController: BaseControllerWithHeader {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
        configureTableView()
        setupUI()
        setupLayout()
    }

    private func getItems() {
        presenter?.getItems { locations in
            self.locations = locations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    init() {
        super.init(type: .withTitle(title: "Ближайшие кофейни", backButton: .backArrowBlack))
        bindBackTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var locations: [Location] = []
    private var onMapButton = UIButton()


    // MARK: - Properties
    var presenter: ViewToPresenterNearestPlacesProtocol?
    private var tableView = UITableView()


    private func configureTableView() {
        contentView.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlaceItemCell.self, forCellReuseIdentifier: "\(PlaceItemCell.self)")
    }

    private func bindBackTap() {
        backButtonTap = {
            self.presenter?.backButtonTapped()
        }
    }

    private func setupUI() {
        onMapButton = UIButton(style: .sighUpButtonStyle)
        onMapButton.setTitle("На карте", for: .normal)
        onMapButton.addTarget(self, action: #selector(onMapTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left)
            $0.right.equalTo(contentView.snp.right)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.top.equalTo(contentView.snp.top).offset(52)
        }

        contentView.addSubview(onMapButton)
        onMapButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-40)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }

    // MARK: - signInTapped
    @objc func onMapTapped() {
        presenter?.onMapTapped()
    }
}

extension NearestPlacesViewController: PresenterToViewNearestPlacesProtocol{
    // TODO: Implement View Output Methods
}

extension NearestPlacesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.title.text = locations[indexPath.row].name
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentWithId(id: locations[indexPath.row].id)
    }
}
