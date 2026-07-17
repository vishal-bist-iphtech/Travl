//
//  ContentView.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject private var tripViewModel = TripViewModel()

    var body: some View {

        DashboardView()
            .environmentObject(tripViewModel)
    }
}

   


#Preview {
    ContentView()
}
