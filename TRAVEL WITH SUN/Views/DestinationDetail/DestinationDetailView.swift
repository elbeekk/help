//
//  DestinationDetailView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct DestinationDetailView: View {
    let destination: String
    var currentUser: User?
    @State private var showingBooking = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "photo.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .background(Color.gray.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(destination)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.8 (1,234 reviews)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("About this destination")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Experience this iconic landmark with a personalized guide who understands your accessibility needs. Our expert guides will ensure you have a comfortable and memorable visit.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Accessibility Features")
                            .font(.headline)
                            .padding(.top)
                        
                        FeatureRow(icon: "figure.roll", text: "Wheelchair accessible")
                        FeatureRow(icon: "ear", text: "Sign language available")
                        FeatureRow(icon: "eye", text: "Audio descriptions")
                        FeatureRow(icon: "elevator.fill", text: "Elevator access")
                    }
                    
                    Button(action: {
                        showingBooking = true
                    }) {
                        Text("Book a Tour Guide")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingBooking) {
            BookingView(destination: destination, currentUser: currentUser)
        }
    }
}
