//
//  TimerScreen.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 28/12/24.
//

import SwiftUI

struct TimerScreen: View {
    
    let timerDuration: Double
    
    @StateObject private var timerVM = TimerViewModel()
    
    var body: some View {
        ZStack {
            TimerBackground(duration: timerDuration, progress: $timerVM.timerProgress, timerRunning: $timerVM.isTimerRunning)
            
            if timerVM.diceThrown {
                Dice()
                
                EndTurnButton()
            } else {
                ThrowDiceButton()
            }
        }
        .onAppear {
            timerVM.startTimer(withDuration: timerDuration)
        }
    }
    
    // MARK: Dice
    
    @ViewBuilder
    private func Dice() -> some View {
        HStack(spacing: 16) {
            WhiteDieView(value: timerVM.whiteDieNumber)
            
            RedDieView(value: timerVM.redDieNumber)
        }
    }
    
    // MARK: Throw Dice
    
    @ViewBuilder
    private func ThrowDiceButton() -> some View {
        VStack {
            Spacer()
            Button("Lançar Dados") {
                timerVM.throwDice()
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 128)
            .font(.title)
            .fontWeight(.bold)
        }
    }
    
    // MARK: End Button
    
    @ViewBuilder
    private func EndTurnButton() -> some View {
        VStack {
            Spacer()
            Button("Passar Dados") {
                timerVM.endTurn { timerVM.startTimer(withDuration: timerDuration) }
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 128)
            .font(.title)
            .fontWeight(.bold)
        }
    }
}

#Preview {
    TimerScreen(timerDuration: 10)
}

