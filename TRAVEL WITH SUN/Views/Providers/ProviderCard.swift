//
//  ProviderCard.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct ProviderCard: View {
    let provider: ServiceProvider
    var currentUser: User?
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: {
            showingDetail = true
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: provider.image)
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(provider.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", provider.rating))
                                .foregroundColor(.secondary)
                        }
                        .font(.caption)
                    }
                    
                    Spacer()
                    
                    Text("$\(Int(provider.hourlyRate))/hr")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Text(provider.bio)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    ForEach(provider.specializations.prefix(3), id: \.self) { spec in
                        Text(spec.rawValue)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .sheet(isPresented: $showingDetail) {
            ProviderDetailView(provider: provider, currentUser: currentUser)
        }
    }
}
