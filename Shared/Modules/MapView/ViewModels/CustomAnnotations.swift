//
//  CustomAnnotations.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import Foundation
import MapKit
import SwiftUI

struct PinAnnotation : MapAnnotationItem {
    let id = UUID()
    let color : Color
    let coordinate: CLLocationCoordinate2D
    
    var annotation: some MapAnnotationProtocol {
        MapPin(coordinate: coordinate, tint: color)
    }
}

struct MarkedPinAnnotation : MapAnnotationItem {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    let meta : String
    let touchCompletion : () -> ()
    
    var annotation: some MapAnnotationProtocol {
        MapAnnotation(
            coordinate: coordinate,
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        ) {
            
            VStack {
                
                Text(meta)
                    .font(.caption2)
                
                Circle()
                    .fill(Color.green.opacity(0.5))
                    .frame(width: 44, height: 44)
                    .onTapGesture(perform: touchCompletion)
                
                
            }
            .animation(.interactiveSpring())
        }
    }
}

struct CircularAnnotation : MapAnnotationItem {
    let id = UUID()
    let color : Color
    let coordinate: CLLocationCoordinate2D
    
    let meta : String
    let touchCompletion : () -> ()
    
    var annotation: some MapAnnotationProtocol {
        MapAnnotation(
            coordinate: coordinate,
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        ) {
            
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.5))
                    .frame(width: 44, height: 44)
                    .onTapGesture(perform: touchCompletion)
                
                Text(meta)
                    .font(.caption2)
            }
            .animation(.interactiveSpring())
        }
    }
}

