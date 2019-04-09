//
//  Station.swift
//
//  Created by Héctor Bautista on 4/7/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Station {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let districtName = "districtName"
        static let address = "address"
        static let addressNumber = "addressNumber"
        static let districtCods = "districtCods"
        static let nearbyStations = "nearbyStations"
        static let status = "status"
        static let stationType = "stationType"
        static let location = "location"
        static let id = "id"
        static let availability = "availability"
        static let zipCode = "zipCode"
        static let districtCode = "districtCode"
    }
    
    // MARK: Properties
    public var name: String?
    public var districtName: String?
    public var address: String?
    public var addressNumber: String?
    public var districtCods: String?
    public var nearbyStations: [Int]?
    public var status: String?
    public var stationType: String?
    public var location: Location?
    public var id: Int?
    public var availability: Availability?
    public var zipCode: String?
    public var districtCode: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public init(json: JSON) {
        name = json[SerializationKeys.name].string
        districtName = json[SerializationKeys.districtName].string
        address = json[SerializationKeys.address].string
        addressNumber = json[SerializationKeys.addressNumber].string
        districtCods = json[SerializationKeys.districtCods].string
        if let items = json[SerializationKeys.nearbyStations].array { nearbyStations = items.map { $0.intValue } }
        status = json[SerializationKeys.status].string
        stationType = json[SerializationKeys.stationType].string
        location = Location(json: json[SerializationKeys.location])
        id = json[SerializationKeys.id].int
        availability = Availability(json: json[SerializationKeys.availability])
        zipCode = json[SerializationKeys.zipCode].string
        districtCode = json[SerializationKeys.districtCode].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = districtName { dictionary[SerializationKeys.districtName] = value }
        if let value = address { dictionary[SerializationKeys.address] = value }
        if let value = addressNumber { dictionary[SerializationKeys.addressNumber] = value }
        if let value = districtCods { dictionary[SerializationKeys.districtCods] = value }
        if let value = nearbyStations { dictionary[SerializationKeys.nearbyStations] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = stationType { dictionary[SerializationKeys.stationType] = value }
        if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = availability { dictionary[SerializationKeys.availability] = value.dictionaryRepresentation() }
        if let value = zipCode { dictionary[SerializationKeys.zipCode] = value }
        if let value = districtCode { dictionary[SerializationKeys.districtCode] = value }
        return dictionary
    }
}
