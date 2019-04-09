//
//  Location.swift
//
//  Created by Héctor Bautista on 4/7/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Location {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    
    // MARK: Properties
    public var longitude: Double?
    public var latitude: Double?
    
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
        longitude = json[SerializationKeys.longitude].double
        latitude = json[SerializationKeys.latitude].double
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = longitude { dictionary[SerializationKeys.longitude] = value }
        if let value = latitude { dictionary[SerializationKeys.latitude] = value }
        return dictionary
    }
}
