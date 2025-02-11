//
//  StockViewModel.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 11/02/25.
//

import Foundation

@MainActor
class StocksViewModel: ObservableObject {
  @Published var stocks: [Stock] = []

  func addStock(_ stock: Stock) {
    stocks.append(stock)
    rebalancePercentages()
  }

  func removeStock(_ stock: Stock) {
    stocks.removeAll { $0.id == stock.id }
    rebalancePercentages()
  }

  private func rebalancePercentages() {
    guard !stocks.isEmpty else { return }
    let equalPercentage = 1.0 / Double(stocks.count)
    stocks = stocks.map { stock in
      var updatedStock = stock
      updatedStock.percentage = equalPercentage
      return updatedStock
    }
  }

  func updatePercentage(for targetStock: Stock, to newPercentage: Double) {
    guard stocks.count > 1,
          let targetIndex = stocks.firstIndex(where: { $0.id == targetStock.id }) else { return }

    // Limita o novo valor entre 0 e 1
    let limitedPercentage = max(0, min(1, newPercentage))

    // Se a nova porcentagem for 0 ou 1, ajusta todas as outras proporcionalmente
    if limitedPercentage == 0 || limitedPercentage == 1 {
      let otherValue = limitedPercentage == 0 ? 1.0 / Double(stocks.count - 1) : 0.0
      stocks = stocks.enumerated().map { index, stock in
        var updatedStock = stock
        updatedStock.percentage = index == targetIndex ? limitedPercentage : otherValue
        return updatedStock
      }
      return
    }

    // Calcula o total atual excluindo a ação alvo
    let currentTotal = stocks.reduce(0.0) { $0 + $1.percentage }
    let otherStocksTotal = currentTotal - stocks[targetIndex].percentage

    // Calcula quanto resta para distribuir
    let remaining = 1.0 - limitedPercentage

    // Ajusta as outras ações proporcionalmente
    let otherStocks = stocks.filter { $0.id != targetStock.id }
    if !otherStocks.isEmpty {
      let scaleFactor = remaining / otherStocksTotal

      stocks = stocks.map { stock in
        var updatedStock = stock
        if stock.id == targetStock.id {
          updatedStock.percentage = limitedPercentage
        } else {
          updatedStock.percentage *= scaleFactor
        }
        return updatedStock
      }
    }
  }
}
