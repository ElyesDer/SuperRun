//
//  MapView.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var viewModel = MapViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749), // maybe use core location to init first location
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    @State var offset: CGFloat = 0
    
    #if os(watchOS)
    @State var showWatchDetails = false
    #endif
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            Map(coordinateRegion: $region, annotationItems: viewModel.annotations)
                .edgesIgnoringSafeArea(.all)
            
            #if os(watchOS)
            
            EmptyView()
                .fullScreenCover(isPresented: $showWatchDetails) {
                    ShowDetailsView(viewModel: SheetViewModel(location: viewModel.selectedCity), closeCompletion: {
                        self.viewModel.selectedCity = nil
                    })
                }
            #else
            GeometryReader { geo in
                
                BottomSheet(offset: $offset, value: (-geo.frame(in: .global).height + 180), viewModel: .init(location: viewModel.selectedCity)) {
                    self.viewModel.selectedCity = nil
                }
                .offset(y: geo.frame(in: .global).height - 160)
                // adding Gesture
                .offset(y: offset)
                .gesture(DragGesture().onChanged({ value in
                    
                    withAnimation {
                        
                        if value.startLocation.y > geo.frame(in: .global).midX {
                            if  offset > (-geo.frame(in: .global).height + 180) {
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
            #endif
        }
        .onReceive(viewModel.$selectedCity, perform: { changes in
            withAnimation(.default, {
                if changes == nil {
                    #if os(watchOS)
                    showWatchDetails = false
                    #else
                    offset = 180
                    #endif
                }else{
                    #if os(watchOS)
                    showWatchDetails = true
                    #else
                    offset = 0
                    #endif
                    
                    if let latitude = changes?.latitude, let longitude = changes?.longitude {
                        region.center = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
                        region.span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                    }
                    
                }
                viewModel.refreshAnnotations()
            })
        })
        .onAppear(perform: {
            viewModel.load()
        })
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
