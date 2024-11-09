//
//  BuyStocksView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 03/08/24.
//

import SwiftUI

struct BuyStocksView: View {
  @State private var dinheiro: Decimal = 1000
  @State private var stocks: [Stock] = Stock.arraySample
  
  
  var body: some View {
    VStack {
      MoneyToSpend(dinheiro: $dinheiro)
      
      Divider()
      
      VStack(alignment: .leading, spacing: 0) {
        Text("Suas ações")
          .font(.subheadline)
        
        List($stocks) { $ativo in
          stockRow(ativo: $ativo, dinheiro: dinheiro)
        }
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color(.secondarySystemBackground))
      )
      .padding()
      
      Spacer()
    }
    .navigationTitle("Comprando Ativos")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationStack {
    BuyStocksView()
  }
}

struct MoneyToSpend: View {
  @Binding var dinheiro: Decimal
  
  var body: some View {
    VStack {
      Text("Quanto quer investir ?")
        .font(.title2)
        .bold()
      
      TextField("Quanto quer investir ?", value: $dinheiro, format: .currency(code: "brl"))
        .keyboardType(.decimalPad)
        .labelsHidden()
        .multilineTextAlignment(.center)
        .font(.title)
        .bold()
        .foregroundStyle(.accentBlue)
    }
  }
}

struct stockRow: View {
  @Binding var ativo: Stock
  var dinheiro: Decimal
  
  var body: some View {
    HStack {
      Text(ativo.code)
        .frame(width: 60)
      
      Divider()
      
      TextField("Porcentagem da compra", value: $ativo.percentage, format: .percent)
        .frame(width: 40)
      
      Divider()
      
      Text("R$ \(ativo.price.description)")
        .frame(width: 70)
      
      Divider()
      
      Text("\((dinheiro * Decimal(ativo.percentage) / ativo.price).description)")
    }
    .frame(maxWidth: .infinity)
  }
}
