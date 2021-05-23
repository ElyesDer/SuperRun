//
//  PinPoint.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import Foundation
import MapKit

protocol PinPoint : Codable {
    var id : UUID? { get set }
    var latitude: Double? { get set }
    var longitude: Double? { get set }
}

// MARK: - PinPoint
struct City: PinPoint {
    var latitude: Double?
    
    var longitude: Double?
    
    var id: UUID? = UUID()
    let city: String
    let isOnline: Bool
    let distance: Int
    let locations: [Location]
//    let latitude, longitude: Double? // Maybe reverse geocoding ?
    
    enum CodingKeys: String, CodingKey {
        case city
        case isOnline = "is_online"
        case distance, locations, latitude, longitude
    }
}

// MARK: - Location
class Location: PinPoint {
    var latitude: Double?
    
    var longitude: Double?
    
    var id: UUID? = UUID()
    let name: String
    
}
