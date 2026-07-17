//
//  NextTripCard.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI
import CoreData

struct NextTripCard: View {
    
    let trip: TripEntity?
    let daysRemaining: Int?
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            
            Image("goa")
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("NEXT TRIP")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Text(
                        daysRemaining != nil
                        ? "\(daysRemaining)d away"
                        : "--"
                    )
                        .font(.caption)
                        .bold()
                        .padding(.horizontal,12)
                        .padding(.vertical, 6)
                        .background(.orange)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
                Spacer()
                
                Text(
                    trip?.destination ?? "No Upcoming Trips"
                )
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                Label {
                    
                    if let trip {
                        
                        Text("\(trip.city ?? ""), \(trip.country ?? "") • \(formattedDateRange)")
                    } else { Text("Plan your next adventure")}
                } icon: {
                Image(systemName: "location")
                }
                .foregroundStyle(.white.opacity(0.9))
                .font(.subheadline)
            }
            .padding()
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    
    private var formattedDateRange: String {

        guard
            let trip,
            let start = trip.startDate,
            let end = trip.endDate
        else {
            return ""
        }

        return "\(start.formatted(date: .abbreviated, time: .omitted)) - \(end.formatted(date: .abbreviated, time: .omitted))"
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let trip = TripEntity(context: context)

    trip.destination = "Goa"

    trip.city = "Goa"

    trip.country = "India"

    trip.startDate = Date()

    trip.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())

    return NextTripCard(
        trip: trip,
        daysRemaining: 5
    )
    .padding()
}
