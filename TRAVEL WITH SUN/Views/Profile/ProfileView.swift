//
//  ProfileView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var currentUser: User?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(currentUser?.name ?? "")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(currentUser?.email ?? "")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Accessibility")) {
                    HStack {
                        Image(systemName: currentUser?.disability.icon ?? "")
                        Text(currentUser?.disability.rawValue ?? "")
                    }
                    if let needs = currentUser?.specificNeeds, !needs.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Special Needs")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(needs)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Settings")) {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink(destination: Text("Help & Support")) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                }
                
                Section {
                    Button(action: {}) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
