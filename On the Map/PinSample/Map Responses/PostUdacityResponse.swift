//
//  PostUdacityResponse.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 08/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation

struct UdacityAccount: Codable {
    let registered: Bool
    let key: String
}

struct UdacitySession: Codable {
    let id: String
    let expiration: String
}

struct PostUdacityResponse: Codable {
    let account: UdacityAccount
    let session: UdacitySession
    
}
