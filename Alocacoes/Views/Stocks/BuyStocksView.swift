//
//  BuyStocksView.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 03/08/24.
//

import SwiftUI

struct BuyStocksView: View {
  @StateObject private var viewModel = StocksViewModel()
  @State private var dinheiro = 0.0
  @State private var showingAddStock = false
  @State private var showTip = true
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    ZStack {
      ScrollView {
        VStack(spacing: 24) {
          // Campo de valor do investimento
          VStack(spacing: 8) {
            Text("Valor do Investimento")
              .font(.headline)
              .foregroundColor(.secondary)

            TextField("R$ 0,00", value: $dinheiro, format: .currency(code: "BRL"))
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.center)
              .font(.system(size: 40, weight: .bold))
              .foregroundStyle(.primary)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 16)
                  .fill(Color(.tertiarySystemBackground))
                  .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
              )
          }
          .padding(.horizontal)

          if viewModel.stocks.isEmpty {
            // Estado vazio
            VStack(spacing: 16) {
              Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 50))
                .foregroundColor(.secondary)

              Text("Nenhuma ação adicionada")
                .font(.headline)
                .foregroundColor(.secondary)

              Button(action: { showingAddStock = true }) {
                Text("Adicionar Ação")
                  .font(.headline)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity)
                  .padding()
                  .background(
                    RoundedRectangle(cornerRadius: 12)
                      .fill(Color.accentColor)
                  )
              }
              .padding(.horizontal)
            }
            .padding(.vertical, 40)
          } else {
            // Card informativo
            if showTip {
              VStack(spacing: 12) {
                HStack {
                  Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                  Text("Dica")
                    .font(.headline)
                  Spacer()
                  Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                      showTip = false
                    }
                  }) {
                    Image(systemName: "xmark.circle.fill")
                      .foregroundColor(.secondary)
                  }
                }

                Text("Recomendamos adicionar todas as ações que você deseja antes de começar a ajustar as porcentagens. Isso tornará mais fácil distribuir os valores.")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 12)
                  .fill(Color(.tertiarySystemBackground))
                  .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
              )
              .padding(.horizontal)
              .transition(.move(edge: .top).combined(with: .opacity))
            }

            // Lista de ações
            VStack(alignment: .leading, spacing: 16) {
              HStack {
                Text("Distribuição dos Ativos")
                  .font(.headline)
                Spacer()
                Button(action: { showingAddStock = true }) {
                  Image(systemName: "plus.circle.fill")
                    .foregroundColor(.accentColor)
                }
              }
              .padding(.horizontal)

              VStack(spacing: 12) {
                ForEach(viewModel.stocks, id: \.id) { stock in
                  VStack(spacing: 8) {
                    HStack {
                      Text(stock.code)
                        .font(.headline)
                      Spacer()
                      Text(valorCalculado(porcentagem: stock.percentage), format: .currency(code: "BRL"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }

                    HStack {
                      Slider(value: Binding(
                        get: { stock.percentage },
                        set: { viewModel.updatePercentage(for: stock, to: $0) }
                      ), in: 0 ... 1, step: 0.01)
                        .tint(.accentColor)

                      Text(stock.percentage, format: .percent.precision(.fractionLength(1)))
                        .font(.callout)
                        .foregroundColor(.accentColor)
                        .frame(width: 70)
                    }
                  }
                  .padding()
                  .background(
                    RoundedRectangle(cornerRadius: 12)
                      .fill(Color(.secondarySystemBackground))
                  )
                  .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                      viewModel.removeStock(stock)
                    } label: {
                      Label("Remover", systemImage: "trash")
                    }
                  }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .padding(.vertical)
      }

      // Botão flutuante de confirmação
      if !viewModel.stocks.isEmpty {
        FloatingActionButton()
      }
    }
    .navigationTitle("Nova Alocação")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $showingAddStock) {
      AddStockView { stock in
        viewModel.addStock(stock)
      }
    }
  }

  private func valorCalculado(porcentagem: Double) -> Double {
    return dinheiro * porcentagem
  }

  private func totalAlocado() -> Double {
    viewModel.stocks.reduce(0) { $0 + $1.percentage }
  }
}

#Preview {
  NavigationStack {
    BuyStocksView()
  }
}
