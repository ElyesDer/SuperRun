//
//  MapViewModel.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import Foundation
import Combine


class MapViewModel: ObservableObject {
    @Published var cities = [City]()
    
    @Published var selectedCity : City?
    
    @Published var annotations : [AnyMapAnnotationItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    func refreshAnnotations() {
        annotations.removeAll()
        cities.forEach { city in
            if city.id == self.selectedCity?.id {
                //                    go through all of its location
                //                    foreach location
                city.locations.forEach { location in
                    annotations.append( .init(PinAnnotation(color: .green, coordinate: .init(latitude: location.latitude , longitude: location.longitude))) )
                }
                
            }else {
                annotations.append(.init(CircularAnnotation(color: .green, coordinate: .init(latitude: city.latitude ?? 45.757542, longitude: city.longitude ?? 4.833007), meta: city.locations.count.description) {
                    self.selectedCity = city
                }))
            }
        }
    }
    
    func load() {
        APIService
            .shared
            .get(of: City.self, from: AppConfig.EndPoints.locations.buildPath())
            .sink { completion in
                switch completion {
                case .failure(_) : print("Request error happeened")
                case .finished : print("request finieshed")
                }
            } receiveValue: { [self] city in
                
                cities.removeAll()
                if city.isOnline {
                    cities.append(city)
                }
                
                refreshAnnotations()
            }
            .store(in: &cancellable)
        
    }
}
