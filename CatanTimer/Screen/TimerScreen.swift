//
//  TimerScreen.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 28/12/24.
//

import SwiftUI

struct TimerScreen: View {
    // Variáveis de controle
    @State private var remainingTime: CGFloat = 60
    @State private var timerIsRunning = false
    
    // Timer publisher
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            TimerBackground(duration: 90)
            
            VStack {
                HStack(spacing: 16) {
                    Image("white_die_test")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .rotationEffect(Angle(degrees: -16))
                    
                    Image("red_die_test")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .rotationEffect(Angle(degrees: 16))
                }
            }
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            }
        }
        .onAppear {
            timerIsRunning = true
        }
        .onDisappear {
            timerIsRunning = false
        }
    }
}

#Preview {
    TimerScreen()
}

