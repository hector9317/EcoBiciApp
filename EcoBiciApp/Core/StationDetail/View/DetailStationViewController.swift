//
//  DetailStationViewController.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit

class DetailStationViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var headerTitle = ["Información General", "Estaciones cercanas", "Ubicación de la estación"]
    var locationManager: CLLocationManager?
    var presenter: DetailStationPresenter?
    var models: [StationModelItem]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var stations: [Station]?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationPermission()
        self.initTableView()
        self.presenter = DetailStationPresenter(view: self)
        guard let stations = self.stations, let index = self.index else { return }
        self.presenter?.getModels(index: index, stations: stations)
    }
    
    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = 40
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(StationTableViewCell.nib, forCellReuseIdentifier: StationTableViewCell.identifier)
        self.tableView.register(MapStationTableViewCell.nib, forCellReuseIdentifier: MapStationTableViewCell.identifier)
        self.tableView.register(NearbyStationsTableViewCell.nib, forCellReuseIdentifier: NearbyStationsTableViewCell.identifier)
    }
}

extension DetailStationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headerTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headerTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        guard let models = self.models else {
            return UITableViewCell()
        }
        let model = models[indexPath.section]
        switch model.type {
        case .GeneralInfo:
            let stationCell = self.tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.identifier, for: indexPath) as! StationTableViewCell
            stationCell.model = model
            cell = stationCell
        case .Map:
            let mapCell = self.tableView.dequeueReusableCell(withIdentifier: MapStationTableViewCell.identifier, for: indexPath) as! MapStationTableViewCell
            mapCell.locationManager = self.locationManager
            mapCell.model = model
            cell = mapCell
        case .NearbyStations:
            let nearbyCell = self.tableView.dequeueReusableCell(withIdentifier: NearbyStationsTableViewCell.identifier, for: indexPath) as! NearbyStationsTableViewCell
            nearbyCell.model = model
            cell = nearbyCell
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

extension DetailStationViewController {
    func locationPermission() {
        if self.locationManager == nil {
            self.locationManager = CLLocationManager()
        }
        self.locationManager?.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        /**
         if CLLocationManager.locationServicesEnabled() {
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
         }
        **/
    }
}

extension DetailStationViewController: DetailStationView {
    func setModels(models: [StationModelItem]?) {
        self.models = models
    }
}
