//
//  ServiceProvider.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import Foundation

struct ServiceProvider {
    var id: UUID = UUID()
    var name: String
    var rating: Double
    var specializations: [DisabilityType]
    var languages: [String]
    var hourlyRate: Double
    var image: String
    var bio: String
}
