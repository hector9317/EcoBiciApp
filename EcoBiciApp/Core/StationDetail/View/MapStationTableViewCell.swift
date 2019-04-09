//
//  MapStationTableViewCell.swift
//  EcoBiciApp
//
//  Created by Héctor Bautista on 4/7/19.
//  Copyright © 2019 Héctor Bautista. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class MapStationTableViewCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var model: StationModelItem? {
        didSet {
            guard let model = self.model as? MapStationModel else {
                return
            }
            self.initMap()
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude ?? 0, longitude: model.longitude ?? 0)
            self.mapView.addAnnotation(annotation)
        }
    }

    func initMap() {
        if let coordinate = self.locationManager?.location?.coordinate{
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

class MapStationModel: StationModelItem {
    var type: StationModelItemType {
        return .Map
    }
    var latitude: Double?
    var longitude: Double?
}
