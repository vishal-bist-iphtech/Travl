//
//  ContentView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//
//


import SwiftUI

struct ContentView: View {

    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var memoryViewModel = MemoryViewModel()
    @StateObject private var bookingViewModel = BookingViewModel()

    @State private var showSplash = true

    var body: some View {

        Group {

            if showSplash {

                SplashView()

            } else {

                TabView {

                    NavigationStack {
                        DashboardView()
                    }
                    .tabItem {
                        Label("Dashboard", systemImage: "house.fill")
                    }

                    NavigationStack {
                        BookingsView()
                    }
                    .tabItem {
                        Label("Bookings", systemImage: "ticket.fill")
                    }

                    NavigationStack {
                        Text("Expenses")
                    }
                    .tabItem {
                        Label("Expenses", systemImage: "indianrupeesign.circle.fill")
                    }

                    NavigationStack {
                        Text("Packing")
                    }
                    .tabItem {
                        Label("Packing", systemImage: "suitcase.rolling.fill")
                    }

                    NavigationStack {
                        Text("Weather")
                    }
                    .tabItem {
                        Label("Weather", systemImage: "cloud.sun.fill")
                    }
                }
                .environmentObject(tripViewModel)
                .environmentObject(memoryViewModel)
                .environmentObject(bookingViewModel)
            }
        }
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {

                withAnimation(.easeInOut) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
