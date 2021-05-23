//
//  PinPoint.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import Foundation
import MapKit

// MARK: - PinPoint
struct City: Codable {
    let id = UUID()
    let city: String
    let isOnline: Bool
    let distance: Int
    let locations: [Location]
    let latitude, longitude: Double? // Maybe reverse geocoding ?
    
    enum CodingKeys: String, CodingKey {
        case city
        case isOnline = "is_online"
        case distance, locations, latitude, longitude
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let latitude, longitude: Double
}
