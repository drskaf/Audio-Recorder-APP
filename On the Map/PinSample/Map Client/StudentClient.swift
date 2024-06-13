//
//  StudentClient.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 13/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation
import MapKit

struct SLocation {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String
}

class LocationsDataSource {
    static let shared = LocationsDataSource()
    
    private init() {}
    
    var locations: [SLocation] = []
    
    func addLocation(_ location: SLocation) {
        locations.append(location)
    }
}
