//
//  EditMemoryView.swift
//  Travl
//
//  Created by iPHTech 34 on 17/07/26.
//

import SwiftUI
import PhotosUI
import CoreData

struct EditMemoryView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var memoryViewModel: MemoryViewModel

    let memory: MemoryEntity

    @State private var title: String
    @State private var note: String
    @State private var rating: Int
    @State private var date: Date

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageData: Data?

    init(memory: MemoryEntity) {

        self.memory = memory

        _title = State(initialValue: memory.title ?? "")
        _note = State(initialValue: memory.note ?? "")
        _rating = State(initialValue: Int(memory.rating))
        _date = State(initialValue: memory.date ?? Date())
        _imageData = State(initialValue: memory.imageData)
    }

    var body: some View {

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

                            VStack {

                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 50))

                                Text("Tap to change photo")
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

                VStack(alignment: .leading) {

                    Text("Title")
                        .font(.headline)

                    TextField("Title", text: $title)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading) {

                    Text("Notes")
                        .font(.headline)

                    TextEditor(text: $note)
                        .frame(height: 120)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                HStack(alignment: .top, spacing: 20) {

                    Text("Rating:")
                        .font(.headline)
                    RatingView(rating: $rating)
                }

                HStack(spacing: 20) {

                    Text("Date:")
                        .font(.title3)

                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .padding(8)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                
            }
        }
        .navigationTitle("Edit Memory")
        .padding()
        .toolbar {
            
//            ToolbarItem(placement: .topBarLeading) {
//                Button("Cancel") {
//                    dismiss()
//                }
//            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                    guard
                        !title.isEmpty
                    else {
                        return
                    }

                    memoryViewModel.updateMemory(
                        memory,
                        title: title,
                        note: note,
                        imageData: imageData,
                        rating: Int16(rating),
                        date: date
                    )

                    dismiss()
                }
                
            }
        }
    }
}

#Preview {

    let context = PersistenceController.shared.container.viewContext

    let memory = MemoryEntity(context: context)

    memory.title = "Beach"
    memory.note = "Nice Sunset"
    memory.rating = 4
    memory.date = Date()

    return NavigationStack {

        EditMemoryView(memory: memory)
    }
    .environmentObject(MemoryViewModel())
}
