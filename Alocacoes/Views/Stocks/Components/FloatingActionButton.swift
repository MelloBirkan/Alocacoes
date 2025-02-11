//
//  FloatingActionButton.swift
//  Alocacoes
//
//  Created by Marcello Gonzatto Birkan on 11/02/25.
//

import SwiftUI

struct FloatingActionButton: View {
  private let text = "Confirmar"
  private let icon: String = "checkmark.circle.fill"
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack {
      Spacer()
      Button(action: {
        dismiss()
      }) {
        HStack {
          Image(systemName: icon)
          Text(text)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
        .background(
          Capsule()
            .fill(Color.accentColor)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        )
      }
      .padding(.bottom, 16)
    }
  }
}

#Preview {
  FloatingActionButton()
}
