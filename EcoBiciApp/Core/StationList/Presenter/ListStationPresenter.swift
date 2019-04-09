//
//  ListStationPresenter.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/6/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import Foundation

class ListStationPresenter {
    var view: ListStationView?
    var interactor: ListStationInteractor?
    
    required init(view: ListStationView) {
        self.view = view
        self.interactor = ListStationInteractor(presenter: self)
    }
    
    func getLocations() {
        let stations = self.interactor?.getStations()
        self.view?.setStations(stations: stations)
    }
}
