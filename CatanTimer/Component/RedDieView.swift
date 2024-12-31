//
//  RedDieView.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 29/12/24.
//

import SwiftUI

struct RedDieView: View {
    
    var value: Int
    private let dieSize: CGFloat = 64 // Tamanho fixo
    private let dotSizeRatio: CGFloat = 0.2 // Proporção do tamanho dos pontos em relação ao dado

    var body: some View {
        let dotSize = dieSize * dotSizeRatio
        let padding = dieSize * 0.1 // Espaçamento adicional das bordas

        ZStack {
            // Fundo do dado
            RoundedRectangle(cornerRadius: dieSize / 8)
                .fill(Color.red)
                .shadow(radius: 5)

            // Posição dos pontos
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { column in
                            if shouldShowDot(row: row, column: column) {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: dotSize, height: dotSize)
                            } else {
                                Spacer()
                            }
                        }
                        .frame(width: (dieSize - 2 * padding) / 3, height: (dieSize - 2 * padding) / 3)
                    }
                }
            }
            .frame(width: dieSize - 2 * padding, height: dieSize - 2 * padding)
        }
        .frame(width: dieSize, height: dieSize) // Define o tamanho fixo do dado
        .padding(padding)
    }

    // Função para determinar quais pontos mostrar
    private func shouldShowDot(row: Int, column: Int) -> Bool {
        let patterns: [[(Int, Int)]] = [
            [(1, 1)], // 1
            [(0, 0), (2, 2)], // 2
            [(0, 0), (1, 1), (2, 2)], // 3
            [(0, 0), (0, 2), (2, 0), (2, 2)], // 4
            [(0, 0), (0, 2), (1, 1), (2, 0), (2, 2)], // 5
            [(0, 0), (0, 1), (0, 2), (2, 0), (2, 1), (2, 2)] // 6
        ]

        guard value >= 1 && value <= 6 else { return false }

        return patterns[value - 1].contains(where: { $0 == (row, column) })
    }
}

struct RedDieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(1...6, id: \.self) { value in
                RedDieView(value: value)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
