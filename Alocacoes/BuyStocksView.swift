//
//  BuyStocksView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 03/08/24.
//

import SwiftUI

struct BuyStocksView: View {
  @State private var dinheiro = 0.0
  @State private var porcentagemCompra = 0.0
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
        
        Divider()
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Suas ações")
            .font(.subheadline)
          
          List(["BBAS3", "SANB11"], id: \.self) { ativo in
            HStack {
              Text(ativo.description)
                .frame(width: 60)
              
              Divider()
              TextField("Porcentagem da compra", value: $porcentagemCompra, format: .percent)
              Divider()
              
              Text((dinheiro * porcentagemCompra).description)
            }
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
