//
//  StudentLocation.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 13/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String?
    let linkedinURL: String? // Add this line to include LinkedIn URL
}

struct StudentLocationsResponse: Codable {
    let results: [StudentLocation]
}
