//
//  AddMemoryView.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//

import SwiftUI
import PhotosUI
import CoreData

struct AddMemoryView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    let trip: TripEntity?
    
    @State private var title = ""
    @State private var note = ""
    @State private var rating = 5
    @State private var date = Date()

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageData: Data?

    var body: some View {

        NavigationStack {
            
            ScrollView {
                
                
                VStack(spacing: 24) {
                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images
                    ) {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.12))
                                .frame(height: 220)
                            
                            if let imageData,
                               let uiImage = UIImage(data: imageData) {
                                
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 220)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                            } else {
                                
                                VStack(spacing: 12) {
                                    
                                    Image(systemName: "photo.badge.plus")
                                        .font(.system(size: 50))
                                    
                                    Text("Tap to add a photo")
                                        .font(.headline)
                                }
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onChange(of: selectedPhoto) { _, newValue in
                        
                        Task {
                            
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                
                                imageData = data
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Title")
                            .font(.headline)
                        
                        TextField("Memory title", text: $title)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Notes")
                            .font(.headline)
                        
                        TextEditor(text: $note)
                            .frame(height: 80)
                            .padding(4)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    
                    HStack{
                        Text("Rating: ")
                            .font(.headline)
                        
                        RatingView(rating: $rating)
                    }
                    
                    
                    HStack{
                        Text("Date: ")
                            .font(.headline)
                        
                        DatePicker(
                            "Memory Date",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                    }
                }
            }
            .navigationTitle("Add Memory")
            .padding()
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
                            return
                        }
                        
                        memoryViewModel.addMemory(
                            title: title,
                            note: note,
                            imageData: imageData,
                            rating: Int16(rating),
                            date: date,
                            trip: trip
                        )
                        
                        dismiss()
                        
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                    
                }
            }
        }
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let trip = TripEntity(context: context)
    trip.title = "Goa"

    return AddMemoryView(trip: nil)
        .environmentObject(MemoryViewModel())
}
