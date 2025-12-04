//
//  ProviderDetailView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct ProviderDetailView: View {
    let provider: ServiceProvider
    var currentUser: User?
    @Environment(\.dismiss) var dismiss
    @State private var showingBooking = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image(systemName: provider.image)
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(provider.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f rating", provider.rating))
                        }
                        
                        Text("About")
                            .font(.headline)
                            .padding(.top)
                        Text(provider.bio)
                            .foregroundColor(.secondary)
                        
                        Text("Specializations")
                            .font(.headline)
                            .padding(.top)
                        ForEach(provider.specializations, id: \.self) { spec in
                            HStack {
                                Image(systemName: spec.icon)
                                Text(spec.rawValue)
                            }
                        }
                        
                        Text("Languages")
                            .font(.headline)
                            .padding(.top)
                        Text(provider.languages.joined(separator: ", "))
                            .foregroundColor(.secondary)
                        
                        Text("Hourly Rate")
                            .font(.headline)
                            .padding(.top)
                        Text("$\(Int(provider.hourlyRate)) per hour")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        Button(action: {
                            showingBooking = true
                        }) {
                            Text("Book This Guide")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingBooking) {
                BookingView(destination: "", currentUser: currentUser, selectedProvider: provider)
            }
        }
    }
}
