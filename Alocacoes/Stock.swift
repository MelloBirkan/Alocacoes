//
//  Stock.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 04/08/24.
//

import Foundation

struct Stock: Identifiable {
  let id = UUID()
  let code: String
  var price: Decimal
  var percentage: Double
}

extension Stock {
  static let arraySample: [Self] = [
    .init(code: "AAPL", price: 100, percentage: 0.1),
    .init(code: "MSFT", price: 200, percentage: 0.2),
    .init(code: "GOOGL", price: 300, percentage: 0.3)
  ]
}
