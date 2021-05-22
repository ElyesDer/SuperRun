//
//  MapView.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import SwiftUI
import MapKit


struct MapView: View {
    @State private var cities: [City] = [
        City(coordinate: .init(latitude: 33.7128, longitude: 10.0060)),
    ]
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.0617, longitude: 10.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: cities) { city in
            MapPin(coordinate: city.coordinate, tint: .green)
            //            MapAnnotation(
            //                coordinate: city.coordinate,
            //                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            //            ) {
            //                Circle()
            //                    .stroke(Color.green)
            //                    .frame(width: 44, height: 44)
            //            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
