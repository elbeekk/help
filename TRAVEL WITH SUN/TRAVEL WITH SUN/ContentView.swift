import SwiftUI

// MARK: - Models
struct User {
    var id: UUID = UUID()
    var name: String
    var email: String
    var disability: DisabilityType
    var specificNeeds: String
}

enum DisabilityType: String, CaseIterable, Identifiable {
    case mobility = "Mobility Impairment"
    case visual = "Visual Impairment"
    case hearing = "Hearing Impairment"
    case cognitive = "Cognitive Disability"
    case multiple = "Multiple Disabilities"
    case other = "Other"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .mobility: return "figure.walk"
        case .visual: return "eye.slash"
        case .hearing: return "ear.badge.waveform"
        case .cognitive: return "brain.head.profile"
        case .multiple: return "person.2"
        case .other: return "ellipsis.circle"
        }
    }
}

struct ServiceProvider {
    var id: UUID = UUID()
    var name: String
    var rating: Double
    var specializations: [DisabilityType]
    var languages: [String]
    var hourlyRate: Double
    var image: String
    var bio: String
}

struct Booking {
    var id: UUID = UUID()
    var destination: String
    var date: Date
    var time: String
    var duration: Int
    var provider: ServiceProvider
    var specialRequests: String
    var status: BookingStatus
}

enum BookingStatus: String {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

// MARK: - Main App
@main
struct AccessibleTravelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Content View
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

// MARK: - Onboarding View
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
                
                if currentStep == 0 {
                    welcomeStep
                } else if currentStep == 1 {
                    personalInfoStep
                } else {
                    disabilityInfoStep
                }
                
                Spacer()
                
                HStack {
                    if currentStep > 0 {
                        Button("Back") {
                            withAnimation {
                                currentStep -= 1
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Button(currentStep == 2 ? "Get Started" : "Next") {
                        withAnimation {
                            if currentStep == 2 {
                                completeOnboarding()
                            } else {
                                currentStep += 1
                            }
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
    
    var welcomeStep: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe.europe.africa.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("Accessible Travel")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your personalized guide to explore the world with confidence and comfort")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
    }
    
    var personalInfoStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Tell us about yourself")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Name")
                    .font(.headline)
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
        }
        .padding()
    }
    
    var disabilityInfoStep: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Help us serve you better")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Select your primary disability type")
                    .font(.headline)
                
                ForEach(DisabilityType.allCases) { type in
                    Button(action: {
                        selectedDisability = type
                    }) {
                        HStack {
                            Image(systemName: type.icon)
                                .font(.title2)
                                .frame(width: 40)
                            
                            Text(type.rawValue)
                                .font(.body)
                            
                            Spacer()
                            
                            if selectedDisability == type {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(selectedDisability == type ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Specific Needs or Requirements")
                        .font(.headline)
                    TextEditor(text: $specificNeeds)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }
            }
            .padding()
        }
    }
    
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

// MARK: - Main Tab View
struct MainTabView: View {
    @Binding var currentUser: User?
    
    var body: some View {
        TabView {
            HomeView(currentUser: currentUser)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProvidersView(currentUser: currentUser)
                .tabItem {
                    Label("Providers", systemImage: "person.2.fill")
                }
            
            BookingsView()
                .tabItem {
                    Label("Bookings", systemImage: "calendar")
                }
            
            ProfileView(currentUser: $currentUser)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

// MARK: - Home View
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

// MARK: - Destination Detail View
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

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(text)
                .font(.body)
        }
    }
}

// MARK: - Providers View
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

// MARK: - Booking View
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

// MARK: - Bookings View
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

// MARK: - Profile View
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
