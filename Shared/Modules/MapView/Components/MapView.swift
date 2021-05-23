//
//  MapView.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import SwiftUI
import MapKit

struct PinAnnotation : MapAnnotationItem {
    let id = UUID()
    let color : Color
    let coordinate: CLLocationCoordinate2D
    
    var annotation: some MapAnnotationProtocol {
        MapPin(coordinate: coordinate, tint: color)
    }
}

struct CircularAnnotation : MapAnnotationItem {
    let id = UUID()
    let color : Color
    let coordinate: CLLocationCoordinate2D
    
    let touchCompletion : () -> ()
    
    var annotation: some MapAnnotationProtocol {
        MapAnnotation(
            coordinate: coordinate,
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        ) {
            Circle()
                .fill(Color.green.opacity(0.5))
                .frame(width: 44, height: 44)
                .onTapGesture(perform: touchCompletion)
        }
    }
}

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


struct MapView: View {
    
    @StateObject var viewModel = MapViewModel()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.0617, longitude: 10.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            Map(coordinateRegion: $region, annotationItems: viewModel.annotations)
                .onTapGesture {
                    viewModel.selectedCity = nil
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
        .onReceive(viewModel.$selectedCity, perform: { changes in
            withAnimation(.default, {
                if changes == nil {
                    offset = 150
                }else{
                    offset = 0
                }
                viewModel.refreshAnnotations()
            })
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
