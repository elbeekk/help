//
//  ProvidersView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct ProvidersView: View {
    var currentUser: User?
    
    let providers = [
        ServiceProvider(name: "Maria Santos", rating: 4.9, specializations: [.mobility, .visual], languages: ["English", "Spanish"], hourlyRate: 45, image: "person.circle.fill", bio: "Experienced guide with 10+ years helping travelers"),
        ServiceProvider(name: "John Chen", rating: 4.8, specializations: [.hearing, .cognitive], languages: ["English", "Mandarin"], hourlyRate: 40, image: "person.circle.fill", bio: "Certified in accessibility support and sign language"),
        ServiceProvider(name: "Emma Williams", rating: 5.0, specializations: [.mobility, .multiple], languages: ["English", "French"], hourlyRate: 50, image: "person.circle.fill", bio: "Specializing in personalized accessible tours"),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(providers, id: \.id) { provider in
                        ProviderCard(provider: provider, currentUser: currentUser)
                    }
                }
                .padding()
            }
            .navigationTitle("Service Providers")
        }
    }
}
