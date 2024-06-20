//
//  LocationMapView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    let coords = CLLocationCoordinate2D(latitude: 41.17054037585928, longitude: -85.49115318980593)
    
    var body: some View {
        Map(bounds: .init(minimumDistance: 900, maximumDistance: 900), interactionModes: []) {
            Marker("Christian Church", coordinate: coords)
                .tint(.gray)
        }
        .frame(height: 250)
        .onTapGesture {
            print("Map Tap")
        }
    }
}

#Preview {
    LocationMapView()
}
