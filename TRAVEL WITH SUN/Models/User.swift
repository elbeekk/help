//
//  User.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import Foundation

struct User {
    var id: UUID = UUID()
    var name: String
    var email: String
    var disability: DisabilityType
    var specificNeeds: String
}
