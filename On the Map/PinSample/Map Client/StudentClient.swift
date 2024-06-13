//
//  StudentClient.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 13/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation
import MapKit

class LocationsDataSource {
    static let shared = LocationsDataSource()
    
    private init() {}
    
    var locations: [StudentLocation] = []
    
    func addLocation(_ location: StudentLocation) {
        locations.append(location)
    }
}
