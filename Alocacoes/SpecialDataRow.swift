//
//  SpecialDataRow.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 23/07/24.
//

import SwiftUI

struct SpecialDataRow: View {
  let title: String
  let percentage: Float
  
    var body: some View {
      VStack(alignment: .leading) {
        Text(title)
          .font(.caption)
          .bold()
          .foregroundStyle(.secondary)
        
        Text(percentage.formatted(.percent))
          .foregroundStyle(percentage >= 0 ? .green : .red)
          .font(.headline)
          .bold()
      }
      .padding(.trailing, 30)
      .padding()
      .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.secondarySystemBackground))
      )
    }
}

#Preview {
  SpecialDataRow(title: "Variação total", percentage: 0.12)
}
