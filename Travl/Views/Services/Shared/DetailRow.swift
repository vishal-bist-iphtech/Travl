//
//  DetailRow.swift
//  Travl
//
//  Created by iPHTech 34 on 16/07/26.
//

import SwiftUI

struct DetailRow: View {

    let title: String
    let value: String

    var body: some View {

        HStack {

            Text(title)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {

    DetailRow(
        title: "Budget",
        value: "₹120000"
    )
    .padding()
}
