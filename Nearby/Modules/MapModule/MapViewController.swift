//
//  MapViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import UIKit
import SnapKit
import YandexMapsMobile



final class MapViewController: BaseControllerWithHeader {

    var presenter: ViewToPresenterMapProtocol?
    init() {
        super.init(type: .withTitle(title: "Карта", backButton: .backArrowBlack))
        bindBackTap()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var locations: [Location] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        getItems()
        setupLayout()
        contentView.addSubview(mapView)
        map = mapView.mapWindow.map
        move()
    }

    private func getItems() {
        presenter?.getItems { [weak self] locations in
            DispatchQueue.main.async {
                self?.locations = locations
                self?.addPlacemarks()
            }
        }
    }

    // Пример обработчика нажатия на метку, отображающего информацию о точке
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        // Отобразить информацию о точке при ее нажатии
        print("Tapped point: \(point.latitude), \(point.longitude)")
        // Дополнительные действия, например, показ информации о местоположении
        return true
    }


    // MARK: - Private methods

    /// Sets the map to specified point, zoom, azimuth and tilt
    private func move(to cameraPosition: YMKCameraPosition = Const.cameraPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }

    private func addPlacemarks() {
        for item in locations {
            let image = UIImage(named: "annotation") ?? UIImage()
            let placemark = map.mapObjects.addPlacemark(with: YMKPoint(latitude: Double(item.point.latitude) ?? 0.0, longitude: Double(item.point.longitude) ?? 0.0))
            placemark.geometry = YMKPoint(latitude: Double(item.point.latitude) ?? 0.0, longitude: Double(item.point.longitude) ?? 0.0)
            placemark.setIconWith(image)
            placemark.setTextWithText(
                "\(item.name)",
                style: YMKTextStyle(
                    size: 12.0,
                    color: .black,
                    outlineColor: .white,
                    placement: .bottom,
                    offset: 0.0,
                    offsetFromIcon: true,
                    textOptional: false
                )
            )
            placemark.isDraggable = true
            placemark.addTapListener(with: mapObjectTapListener)
        }
    }

    // MARK: - Private properties

    private var mapView = YMKMapView()
    private var map: YMKMap!


    /// Handles map object taps
    /// - Note: This should be declared as property to store a strong reference
    private lazy var mapObjectTapListener: YMKMapObjectTapListener = MapObjectTapListener(controller: self)

    /// Handles map object taps
    final private class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
        init(controller: UIViewController) {
            self.controller = controller
        }

        func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
            AlertPresenter.present(
                from: controller,
                with: "Tapped point",
                message: "\((point.latitude, point.longitude))"
            )
            print("Tapped point \((point.latitude, point.longitude))")
            return true
        }

        private weak var controller: UIViewController?
    }

    private enum Const {
        static let point = YMKPoint(latitude: 44.83, longitude: 44.83)
        static let cameraPosition = YMKCameraPosition(target: point, zoom: 10.0, azimuth: 150.0, tilt: 30.0)
    }


    // MARK: - setUpLayout

    func setupLayout() {
        self.contentView.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.right.equalTo(contentView)
            $0.top.equalTo(contentView).offset(52)
            $0.bottom.equalTo(contentView)
        }
    }

    private func bindBackTap() {
        backButtonTap = {
            self.presenter?.backButtonTapped()
        }
    }
}
extension MapViewController: PresenterToViewMapProtocol {
    // TODO: Implement View Output Methods
}


enum AlertPresenter {
    static func present(from controller: UIViewController?, with text: String, message: String? = nil) {
        guard let controller = controller else {
            return
        }
        let alertVC = UIAlertController(title: text, message: message, preferredStyle: .actionSheet)
        controller.present(alertVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alertVC.dismiss(animated: true)
        }
    }
}
