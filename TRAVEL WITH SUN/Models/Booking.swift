//
//  Booking.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import Foundation

struct Booking {
    var id: UUID = UUID()
    var destination: String
    var date: Date
    var time: String
    var duration: Int
    var provider: ServiceProvider
    var specialRequests: String
    var status: BookingStatus
}
