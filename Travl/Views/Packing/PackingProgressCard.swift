//
//  PackingProgressCard.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import SwiftUI

struct PackingProgressCard: View {

    let packed: Int
    let total: Int

    private var progress: Double {

        guard total > 0 else { return 0 }

        return Double(packed) / Double(total)
    }

    private var remaining: Int {

        total - packed
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                VStack(alignment: .leading, spacing: 4) {

                    Text("Packing Progress")
                        .font(.headline)

                    Text("\(packed) of \(total) items packed")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                ZStack {

                    Circle()
                        .stroke(.white.opacity(0.25), lineWidth: 8)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))

                    Text("\(Int(progress * 100))%")
                        .font(.headline.bold())
                }
                .frame(width: 70, height: 70)
            }

            ProgressView(value: progress)
                .tint(.white)

            HStack {

                VStack(alignment: .leading) {

                    Text("Packed")
                        .font(.caption)

                    Text("\(packed)")
                        .font(.title2.bold())
                }

                Spacer()

                VStack(alignment: .center) {

                    Text("Remaining")
                        .font(.caption)

                    Text("\(remaining)")
                        .font(.title2.bold())
                }

                Spacer()

                VStack(alignment: .trailing) {

                    Text("Total")
                        .font(.caption)

                    Text("\(total)")
                        .font(.title2.bold())
                }
            }
            .foregroundStyle(.white)
        }
        .padding()
        .foregroundStyle(.white)
        .background(
            LinearGradient(
                colors: [
                    .blue,
                    .cyan
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {

    PackingProgressCard(
        packed: 8,
        total: 12
    )
    .padding()
}
