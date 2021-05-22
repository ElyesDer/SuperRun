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
    
    @State var offset: CGFloat = 0
    
    @State var toooogle : Bool = false
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Map(coordinateRegion: $region, annotationItems: cities) { city in
                MapPin(coordinate: city.coordinate, tint: .green)
            }
            .onTapGesture {
                toooogle.toggle()
            }
            .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                
                BottomSheet(offset: $offset, value: (-geo.frame(in: .global).height + 150))
                    .offset(y: geo.frame(in: .global).height - 140)
                    // adding Gesture
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged({ value in
                        
                        withAnimation {
                            
                            if value.startLocation.y > geo.frame(in: .global).midX {
                                if  offset > (-geo.frame(in: .global).height + 150) {
                                    offset = value.translation.height
                                }
                            }
                        }
                    }).onEnded({ value in
                        withAnimation {
                            offset = 0
                        }
                    }))
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
