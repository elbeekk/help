//
//  BookingsView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct BookingsView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedTab) {
                    Text("Upcoming").tag(0)
                    Text("Past").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    upcomingBookings
                } else {
                    pastBookings
                }
            }
            .navigationTitle("My Bookings")
        }
    }
    
    var upcomingBookings: some View {
        ScrollView {
            VStack(spacing: 15) {
                BookingCard(
                    destination: "Eiffel Tower, Paris",
                    date: "Dec 15, 2024",
                    time: "10:00 AM",
                    provider: "Maria Santos",
                    status: .confirmed
                )
                BookingCard(
                    destination: "Colosseum, Rome",
                    date: "Dec 20, 2024",
                    time: "2:00 PM",
                    provider: "John Chen",
                    status: .pending
                )
            }
            .padding()
        }
    }
    
    var pastBookings: some View {
        ScrollView {
            VStack(spacing: 15) {
                BookingCard(
                    destination: "Big Ben, London",
                    date: "Nov 10, 2024",
                    time: "11:00 AM",
                    provider: "Emma Williams",
                    status: .completed
                )
            }
            .padding()
        }
    }
}

struct BookingCard: View {
    let destination: String
    let date: String
    let time: String
    let provider: String
    let status: BookingStatus
    
    var statusColor: Color {
        switch status {
        case .pending: return .orange
        case .confirmed: return .green
        case .completed: return .blue
        case .cancelled: return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(destination)
                    .font(.headline)
                Spacer()
                Text(status.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.2))
                    .foregroundColor(statusColor)
                    .cornerRadius(5)
            }
            
            HStack {
                Image(systemName: "calendar")
                Text(date)
                Image(systemName: "clock")
                    .padding(.leading)
                Text(time)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            Divider()
            
            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.blue)
                Text(provider)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
