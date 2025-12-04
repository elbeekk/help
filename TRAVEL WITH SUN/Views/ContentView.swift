//
//  ContentView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboarded = false
    @State private var currentUser: User?

    var body: some View {
        Group {
            if !isOnboarded {
                OnboardingView(isOnboarded: $isOnboarded, currentUser: $currentUser)
            } else {
                MainTabView(currentUser: $currentUser)
            }
        }
    }
}
