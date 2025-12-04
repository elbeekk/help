//
//  BookingView.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct BookingView: View {
    let destination: String
    var currentUser: User?
    var selectedProvider: ServiceProvider?
    
    @Environment(\.dismiss) var dismiss
    @State private var bookingDestination = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = "10:00 AM"
    @State private var duration = 2
    @State private var specialRequests = ""
    @State private var showingConfirmation = false
    
    let timeSlots = ["9:00 AM", "10:00 AM", "11:00 AM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Destination")) {
                    TextField("Enter destination", text: $bookingDestination)
                }
                
                Section(header: Text("Date & Time")) {
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    Picker("Time", selection: $selectedTime) {
                        ForEach(timeSlots, id: \.self) { time in
                            Text(time).tag(time)
                        }
                    }
                    Stepper("Duration: \(duration) hours", value: $duration, in: 1...8)
                }
                
                Section(header: Text("Special Requests")) {
                    TextEditor(text: $specialRequests)
                        .frame(height: 100)
                }
                
                if let provider = selectedProvider {
                    Section(header: Text("Selected Provider")) {
                        HStack {
                            Image(systemName: provider.image)
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(provider.name)
                                    .font(.headline)
                                Text("$\(Int(provider.hourlyRate))/hr")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Total Cost")) {
                        HStack {
                            Text("Estimated Total")
                            Spacer()
                            Text("$\(Int(provider.hourlyRate * Double(duration)))")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        showingConfirmation = true
                    }) {
                        Text("Confirm Booking")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("Book Appointment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Booking Confirmed!", isPresented: $showingConfirmation) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your tour has been booked successfully. You'll receive a confirmation email shortly.")
            }
        }
        .onAppear {
            if !destination.isEmpty {
                bookingDestination = destination
            }
        }
    }
}
