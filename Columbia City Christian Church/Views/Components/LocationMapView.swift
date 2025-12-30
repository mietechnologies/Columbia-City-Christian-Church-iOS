//
//  LocationMapView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    let coords: CLLocationCoordinate2D
    
    /// Default: latitude and longitude set to church coordinates
    init(latitude: CLLocationDegrees = 41.17054037585928, longitude: CLLocationDegrees = -85.49115318980593) {
        coords = .init(latitude: latitude, longitude: longitude)
    }
    
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
        .padding(.horizontal)
}
