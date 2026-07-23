//
//  WeatherDashboardView.swift
//  Travl
//
//  Created by iPHTech 34 on 23/07/26.
//

import SwiftUI

struct WeatherDashboardView: View {

    private let weather = WeatherData.sample

    private let columns = [

        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 20) {

                    WeatherCard(
                        weather: weather
                    )

                    LazyVGrid(
                        columns: columns,
                        spacing: 16
                    ) {

                        WeatherMetricCard(
                            title: "Humidity",
                            value: "\(weather.humidity)%",
                            systemImage: "humidity.fill",
                            color: .blue
                        )

                        WeatherMetricCard(
                            title: "Wind",
                            value: "\(weather.windSpeed) km/h",
                            systemImage: "wind",
                            color: .cyan
                        )

                        WeatherMetricCard(
                            title: "Rain Chance",
                            value: "\(weather.rainChance)%",
                            systemImage: "cloud.rain.fill",
                            color: .indigo
                        )

                        WeatherMetricCard(
                            title: "UV Index",
                            value: "\(weather.uvIndex)",
                            systemImage: "sun.max.fill",
                            color: .orange
                        )
                    }

                    HourlyForecastCard(
                        hourly: weather.hourly
                    )

                    WeeklyForecastCard(
                        weekly: weather.weekly
                    )
                }
                .padding()
            }
            .navigationTitle("Weather")
        }
    }
}

#Preview {

    WeatherDashboardView()
}
