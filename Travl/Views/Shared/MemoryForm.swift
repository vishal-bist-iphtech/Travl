//
//  MemoryForm.swift
//  Travl
//
//  Created by iPHTech 34 on 21/07/26.
//

import SwiftUI
import PhotosUI

struct MemoryForm: View {

    @Binding var title: String
    @Binding var note: String

    @Binding var rating: Int
    @Binding var selectedItem: PhotosPickerItem?

    var body: some View {

        Form {

            Section("Memory") {

                TextField("Title", text: $title)

                TextEditor(text: $note)
                    .frame(height: 120)
            }

            Section("Rating") {

                Stepper(
                    "Rating: \(rating)/5",
                    value: $rating,
                    in: 1...5
                )
            }

            Section("Photo") {

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {

                    Label(
                        "Choose Photo",
                        systemImage: "photo"
                    )
                }
            }
        }
    }
}
