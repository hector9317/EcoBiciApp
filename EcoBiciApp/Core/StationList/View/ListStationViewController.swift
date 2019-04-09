//
//  ListStationViewController.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/6/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import Foundation
import UIKit

class ListStationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ListStationPresenter?
    var stations: [Station]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.title = ListStationTexts.listTitle
        self.presenter = ListStationPresenter(view: self)
        self.presenter?.getLocations()
    }

    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderHeight = 40
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(StationTableViewCell.nib, forCellReuseIdentifier: StationTableViewCell.identifier)
    }
}

extension ListStationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.stations?.count else {
            return 0
        }
        return count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ListStationTexts.headerList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.identifier, for: indexPath) as? StationTableViewCell else {
            return UITableViewCell()
        }
        if let stations = self.stations {
            cell.station = stations[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let stations = self.stations {
            if stations[indexPath.row].availability?.slots == 0 {
                return nil
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = Utils.getController(storyboard: StoryboardIdentifiers.detailStation, controller: ViewControllerIdentifiers.detailStationViewController) as? DetailStationViewController else {
            return
        }
        controller.index = indexPath.row
        controller.stations = self.stations
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListStationViewController: ListStationView {
    func setStations(stations: [Station]?) {
        self.stations = stations
    }
}
