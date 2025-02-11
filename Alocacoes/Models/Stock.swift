//
//  Stock.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 04/08/24.
//

import Foundation

struct Stock {
  let id = UUID()
  let code: String
  var price: Decimal
  var percentage: Double
}
