//
//  DetailStationPresenter.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import CoreLocation
import Foundation

class DetailStationPresenter {
    var view: DetailStationView?
    
    required init(view: DetailStationView) {
        self.view = view
    }
    
    func getModels(index: Int, stations: [Station]) {
        let station = stations[index]
        var models = [StationModelItem]()
        let stationModel = StationModel()
        stationModel.address = (station.address ?? "") + ", " + (station.districtName ?? "")
        stationModel.slots = station.availability?.slots
        
        let mapStation = MapStationModel()
        mapStation.latitude = station.location?.latitude
        mapStation.longitude = station.location?.longitude
        
        let nearbyModel = NearbyStationModel()
        var nearbies = ""
        if let nearbyStations = station.nearbyStations {
            for idNearby in nearbyStations {
                let idNearby = idNearby - 1 >= 0 ? idNearby - 1 : idNearby + 1
                let address = stations[(idNearby) % stations.count].address ?? ""
                let districtName = stations[(idNearby) % stations.count].districtName ?? ""
                nearbies += "- " + address + ", " + districtName + ", CDMX.\n"
            }
        }
        nearbyModel.nearbies = nearbies
        
        models.append(stationModel)
        models.append(nearbyModel)
        models.append(mapStation)
        self.view?.setModels(models: models)
    }
}
