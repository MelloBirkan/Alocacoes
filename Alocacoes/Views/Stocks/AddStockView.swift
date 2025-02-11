//
//  AddStockView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 11/02/25.
//

import SwiftUI

struct AddStockView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var stockCode = ""
  var onAddStock: (Stock) -> Void

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Código da Ação (ex: PETR4)", text: $stockCode)
            .textInputAutocapitalization(.characters)
        }
      }
      .navigationTitle("Adicionar Ação")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancelar") {
            dismiss()
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("Adicionar") {
            let stock = Stock(code: stockCode.uppercased(), price: 0, percentage: 0)
            onAddStock(stock)
            dismiss()
          }
          .disabled(stockCode.isEmpty)
        }
      }
    }
  }
}

#Preview {
  AddStockView { _ in }
}

