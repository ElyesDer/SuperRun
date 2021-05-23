//
//  MapViewModel.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import Foundation
import Combine


class MapViewModel: ObservableObject {
    @Published var cities : [City] = [
        City(coordinate: .init(latitude: 33.7128, longitude: 10.0060)),
    ]
    
    @Published var selectedCity : City? = City(coordinate: .init(latitude: 33.7128, longitude: 10.0060))
    
    @Published var annotations : [AnyMapAnnotationItem] = []
    
    
    func refreshAnnotations() {
        annotations.removeAll()
        cities.forEach { city in
            if city.id == self.selectedCity?.id {
                //                    go through all of its location
                //                    foreach location
                annotations.append( .init(PinAnnotation(color: .red, coordinate: city.coordinate)) )
                
            }else {
                annotations.append(.init(CircularAnnotation(color: .red, coordinate: city.coordinate) {
                    self.selectedCity = city
                }))
            }
        }
    }
}
