//
//  BookingDetailsView.swift
//  Travl
//
//  Created by iPHTech 34 on 20/07/26.
//

import SwiftUI
import CoreData

struct BookingDetailView: View {
    
    @EnvironmentObject private var bookingViewModel: BookingViewModel
    @Environment(\.dismiss) private var dismiss

    let booking: BookingEntity
    
    @State private var showEditBooking = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: Booking Type
                
                HStack(spacing: 16) {
                    
                    Image(systemName: bookingViewModel.bookingIcon(booking: booking))
                        .font(.system(size: 34))
                        .foregroundStyle(.blue)
                        .frame(width: 70, height: 70)
                        .background(Color.blue.opacity(0.12))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(booking.title ?? "")
                            .font(.title.bold())
                        
                        Text(booking.bookingType ?? "")
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                // MARK: Booking Information
                
                DetailRow(
                    title: "Provider",
                    value: booking.provider ?? "-"
                )
                
                DetailRow(
                    title: "Booking Reference",
                    value: booking.bookingReference ?? "-"
                )
                
                DetailRow(
                    title: "Status",
                    value: booking.status ?? "-"
                )
                
                DetailRow(
                    title: "Currency",
                    value: booking.currency ?? "-"
                )
                
                DetailRow(
                    title: "Amount",
                    value: "\(booking.amount, default: "%.2f")"
                )
                
                DetailRow(
                    title: "Start Date",
                    value: booking.startDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                )
                
                DetailRow(
                    title: "End Date",
                    value: booking.endDate?.formatted(date: .abbreviated, time: .omitted) ?? "-"
                )
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Notes")
                        .font(.headline)
                    
                    Text(
                        booking.notes?.isEmpty == false
                        ? booking.notes!
                        : "No notes available."
                    )
                    .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Booking")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                NavigationLink {

                    EditBookingView(booking: booking)
                        .environmentObject(bookingViewModel)

                } label: {

                    Image(systemName: "square.and.pencil")
                }

                Button(role: .destructive) {

                    showDeleteAlert = true

                } label: {

                    Image(systemName: "trash")
                }
            }
        }
        .alert("Delete Booking?", isPresented: $showDeleteAlert) {

            Button("Delete", role: .destructive) {

                bookingViewModel.deleteBooking(booking)

                dismiss()
            }

            Button("Cancel", role: .cancel) { }

        } message: {

            Text("This action cannot be undone.")
        }
    }
}

#Preview {

    let context = PersistenceController.preview.container.viewContext

    let booking = BookingEntity(context: context)

    booking.title = "Delhi to Goa"
    booking.bookingType = "Flight"
    booking.provider = "IndiGo"
    booking.bookingReference = "6E8452"
    booking.status = "Confirmed"
    booking.currency = "INR"
    booking.amount = 7800
    booking.notes = "Window seat preferred."
    booking.startDate = .now
    booking.endDate = Calendar.current.date(byAdding: .day, value: 5, to: .now)

    return NavigationStack {

        BookingDetailView(
            booking: booking
        )
    }
    .environmentObject(BookingViewModel())
}
