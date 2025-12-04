//
//  HomeView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//


import SwiftUI

struct HomeView: View {
    var currentUser: User?
    @State private var searchText = ""
    
    let popularDestinations = [
        "Eiffel Tower, Paris",
        "Colosseum, Rome",
        "Times Square, NYC",
        "Big Ben, London",
        "Sagrada Familia, Barcelona"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Welcome Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hello, \(currentUser?.name ?? "Traveler")!")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Where would you like to explore today?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search destinations...", text: $searchText)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                QuickActionCard(icon: "location.fill", title: "Book Tour", color: .blue)
                                QuickActionCard(icon: "message.fill", title: "Chat Support", color: .green)
                                QuickActionCard(icon: "map.fill", title: "Accessible Routes", color: .orange)
                                QuickActionCard(icon: "star.fill", title: "Top Rated", color: .purple)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Popular Destinations
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Popular Destinations")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(popularDestinations, id: \.self) { destination in
                            NavigationLink(destination: DestinationDetailView(destination: destination, currentUser: currentUser)) {
                                DestinationCard(destination: destination)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Explore")
        }
    }
}

struct QuickActionCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .cornerRadius(10)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(width: 100)
    }
}

struct DestinationCard: View {
    let destination: String
    
    var body: some View {
        HStack {
            Image(systemName: "building.2.fill")
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(destination)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Accessible tours available")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
