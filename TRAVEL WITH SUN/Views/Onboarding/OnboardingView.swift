//
//  OnboardingView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarded: Bool
    @Binding var currentUser: User?
    @State private var currentStep = 0
    @State private var name = ""
    @State private var email = ""
    @State private var selectedDisability: DisabilityType = .mobility
    @State private var specificNeeds = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ProgressView(value: Double(currentStep + 1), total: 3)
                    .padding(.horizontal)

                if currentStep == 0 { welcomeStep }
                else if currentStep == 1 { personalInfoStep }
                else { disabilityInfoStep }

                Spacer()

                HStack {
                    if currentStep > 0 {
                        Button("Back") {
                            withAnimation { currentStep -= 1 }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }

                    Button(currentStep == 2 ? "Get Started" : "Next") {
                        withAnimation {
                            if currentStep == 2 { completeOnboarding() }
                            else { currentStep += 1 }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(currentStep == 1 && (name.isEmpty || email.isEmpty))
                }
                .padding()
            }
            .navigationTitle("Welcome")
        }
    }

    var welcomeStep: some View { /* unchanged */ }

    var personalInfoStep: some View { /* unchanged */ }

    var disabilityInfoStep: some View { /* unchanged */ }

    func completeOnboarding() {
        currentUser = User(
            name: name,
            email: email,
            disability: selectedDisability,
            specificNeeds: specificNeeds
        )
        isOnboarded = true
    }
}
