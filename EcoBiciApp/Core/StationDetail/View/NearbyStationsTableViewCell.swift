//
//  NearbyStationsTableViewCell.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import UIKit

class NearbyStationsTableViewCell: UITableViewCell {
    @IBOutlet weak var lbNearbies: UILabel!
    var model: StationModelItem? {
        didSet {
            guard let model = self.model as? NearbyStationModel else { return }
            self.lbNearbies.text = model.nearbies ?? ""
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

class NearbyStationModel: StationModelItem {
    var type: StationModelItemType {
        return .NearbyStations
    }
    var nearbies: String?
}
