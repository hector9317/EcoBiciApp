//
//  ListStationInteractor.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/6/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListStationInteractor {
    var presenter: ListStationPresenter?
    
    required init(presenter: ListStationPresenter) {
        self.presenter = presenter
    }
    
    func getStations() -> [Station]? {
        var stations: [Station]? = [Station]()
        let districtCodes = ["CHA", "BUE", "CEN", "CON", "CUA", "DOC", "ESC", "GRA", "HIP", "H-C", "JUA", "POL", "R-N", "ROM", "SMC", "S-R", "TAB", "ACA", "ACT", "AMN", "CDD", "DVC", "DVN", "DVS", "EXI"]
        let districtNames = ["Bosque de Chapultepec", "Buenavista", "Centro", "Condesa", "Cuauhtémoc", "Doctores", "Escandón", "Granada", "Hipódromo", "Hipódromo Condesa", "Juárez", "Polanco", "Roma Norte", "Roma Sur", "San Miguel Chapultepec", "San Rafael", "Tabacalera", "Acacias", "Actipan", "Ampliación Nápoles", "Ciudad de los Deportes", "Del Valle Centro", "Del Valle Norte", "Del Valle Sur", "Extremadura Insurgentes"]
        let status = ["OPN", "CLS"]
        for i in Array(0..<25) {
            var station = Station(object: [])
            station.id = i + 1
            station.name = "ECO " + String(describing: Int.random(in: 99 ... 1000))
            station.address = "Calle " + String(describing: Int.random(in: 1 ... 100))
            station.addressNumber = String(describing: Int.random(in: 1 ... 50))
            station.zipCode = String(describing: Int.random(in: 1000 ... 9999))
            station.districtCode = districtCodes[i]
            station.districtName = districtNames[i]
            station.nearbyStations = Array(i + 2 ... i + 5).map({ $0 % 26 })
            station.stationType = "Normal"
            station.status = status[i % 2]
            var availability = Availability(object: [])
            availability.bikes = Int.random(in: 0 ... 10)
            availability.slots = Int.random(in: 0 ... 10)
            var location = Location(object: [])
            station.availability = availability
            location.latitude = Double.random(in: 19 ... 19.3)
            location.longitude = Double.random(in: -99.2 ... -99)
            station.location = location
            stations?.append(station)
        }
        return stations
    }
}
