//
//  ContentView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 23/07/24.
//

import SwiftUI
import Charts

struct ContentView: View {
  var body: some View {
    NavigationStack {
      ScrollView {
        ZStack {
          VStack(alignment: .leading) {
            Text("Patrimonio Atual")
              .foregroundStyle(.secondary)
              
            Text(1234, format: .currency(code: "brl"))
              .font(.largeTitle)
              .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                SpecialDataRow(title: "Variação total", percentage: 0.12)
                SpecialDataRow(title: "Variação total", percentage: 0.62)
                SpecialDataRow(title: "Variação total", percentage: -0.56)
              }
            }
            
            ChartLineRow()
            
            ChartLineRow()
            
            Spacer()
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        }
      }
      .navigationTitle("Carteira Atual")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ContentView()
}
