//
//  WeeklyForecastCard.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct WeeklyForecastCard: View {

    let weekly: [DailyWeather]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("7-Day Forecast")
                .font(.title3.bold())

            VStack(spacing: 12) {

                ForEach(weekly) { forecast in

                    HStack {

                        Text(forecast.day)
                            .frame(width: 45, alignment: .leading)

                        Image(systemName: forecast.icon)
                            .font(.title3)
                            .symbolRenderingMode(.multicolor)
                            .frame(width: 35)

                        Spacer()

                        Text("\(forecast.high)°")
                            .fontWeight(.semibold)

                        Text("/")

                        Text("\(forecast.low)°")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)

                    if forecast.id != weekly.last?.id {

                        Divider()
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )
    }
}

#Preview {

    WeeklyForecastCard(
        weekly: WeatherData.sample.weekly
    )
    .padding()
}
