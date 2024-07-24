//
//  ChartView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 23/07/24.
//

import SwiftUI
import Charts

struct PerformanceData: Identifiable {
  let id = UUID()
  let date: Date
  let value: Double
}

struct ChartLineRow: View {
  let performanceData: [PerformanceData] = [
    PerformanceData(date: Date().addingTimeInterval(-3600*24*30), value: 1),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*25), value: 100),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*20), value: 1600),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*15), value: 1380),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*10), value: 1620),
    PerformanceData(date: Date().addingTimeInterval(-3600*24*5), value: 1650),
    PerformanceData(date: Date(), value: 1700)
  ]
  
  var body: some View {
    VStack(alignment: .leading) {
      VStack(alignment: .leading) {
        Label("Evolução da Carteira", systemImage: "chart.line.uptrend.xyaxis")
          .font(.title3.bold())
          .foregroundStyle(.accentBlue)
        
        Text("Last 28 Days")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      Chart {
        ForEach(performanceData) { data in
          LineMark(
            x: .value("Date", data.date),
            y: .value("Value", data.value)
          )
          .symbol(by: .value("Date", data.date))
          .foregroundStyle(.blue)
        }
      }
      .frame(height: 300)
      .padding()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.secondarySystemBackground))
    )
  }
}

#Preview {
  ChartLineRow()
}
