//
//  Map+.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import Foundation
import SwiftUI
import MapKit

protocol MapAnnotationItem: Identifiable {
    associatedtype Annotation: MapAnnotationProtocol

    var coordinate: CLLocationCoordinate2D { get }
    var annotation: Annotation { get }
}

struct AnyMapAnnotationItem: MapAnnotationItem {
    let id: AnyHashable
    let coordinate: CLLocationCoordinate2D
    let annotation: AnyMapAnnotation
    let base: Any

    init<T: MapAnnotationItem>(_ base: T) {
        self.id = base.id
        self.coordinate = base.coordinate
        self.annotation = AnyMapAnnotation(base.annotation)
        self.base = base
    }
}

struct AnyMapAnnotation: MapAnnotationProtocol {
    let _annotationData: _MapAnnotationData
    let base: Any

    init<T: MapAnnotationProtocol>(_ base: T) {
        self._annotationData = base._annotationData
        self.base = base
    }
}

extension Map {

    init<Items>(
        coordinateRegion: Binding<MKCoordinateRegion>,
        interactionModes: MapInteractionModes = .all,
        showsUserLocation: Bool = false,
        userTrackingMode: Binding<MapUserTrackingMode>? = nil,
        annotationItems: Items
    ) where Content == _DefaultAnnotatedMapContent<Items>,
        Items: RandomAccessCollection,
        Items.Element == AnyMapAnnotationItem
    {
        self.init(
            coordinateRegion: coordinateRegion,
            interactionModes: interactionModes,
            showsUserLocation: showsUserLocation,
            userTrackingMode: userTrackingMode,
            annotationItems: annotationItems,
            annotationContent: { $0.annotation }
        )
    }

    init<Items>(
        mapRect: Binding<MKMapRect>,
        interactionModes: MapInteractionModes = .all,
        showsUserLocation: Bool = false,
        userTrackingMode: Binding<MapUserTrackingMode>? = nil,
        annotationItems: Items
    ) where Content == _DefaultAnnotatedMapContent<Items>,
        Items: RandomAccessCollection,
        Items.Element == AnyMapAnnotationItem
    {
        self.init(
            mapRect: mapRect,
            interactionModes: interactionModes,
            showsUserLocation: showsUserLocation,
            userTrackingMode: userTrackingMode,
            annotationItems: annotationItems,
            annotationContent: { $0.annotation }
        )
    }
}
