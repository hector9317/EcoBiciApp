//
//  StationTableViewCell.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/6/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbAvailability: UILabel!
    @IBOutlet weak var imgSlot: UIImageView!
    
    var model: StationModelItem? {
        didSet {
            guard let model = self.model as? StationModel else { return }
            let slots = model.slots ?? 0
            self.lbAddress.text = model.address
            self.lbAvailability.text = slots == 0 ? ListStationTexts.emptySlots : ListStationTexts.availableSlots.replacingOccurrences(of: "#", with: String(describing: slots))
            self.lbAvailability.textColor = slots == 0 ? UIColor.red : UIColor.darkGray
            self.imgSlot.image = slots > 0 ? UIImage(named: "ic_slots") : nil
        }
    }
    
    var station: Station? {
        didSet {
            guard let station = self.station else { return }
            let slots = station.availability?.slots ?? 0
            self.lbAddress.text = (station.address ?? "") + ", " + (station.districtName ?? "")
            self.lbAvailability.text = slots == 0 ? ListStationTexts.emptySlots : ListStationTexts.availableSlots.replacingOccurrences(of: "#", with: String(describing: slots))
            self.lbAvailability.textColor = slots == 0 ? UIColor.red : UIColor.darkGray
            self.imgSlot.image = slots > 0 ? UIImage(named: "ic_slots") : nil
        }
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

class StationModel: StationModelItem {
    var type: StationModelItemType {
        return .GeneralInfo
    }
    var address: String?
    var slots: Int?
}
