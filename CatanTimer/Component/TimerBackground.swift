//
//  TimerBackground.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 28/12/24.
//

import SwiftUI

struct TimerBackground: View {
    @State private var progress: CGFloat = 1.0
    @State private var timerRunning = false
    
    var duration: TimeInterval // Duração do timer em segundos

    var body: some View {
        ZStack {
            Rectangle()
                .fill(progress < 0.25 ? .red : .green)
                .frame(height: UIScreen.main.bounds.height)
                .offset(y: UIScreen.main.bounds.height * (1 - progress))
                .animation(.easeInOut(duration: 0.1), value: progress)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTimer()
            }
        }
    }

    func startTimer() {
        if timerRunning {
            resetTimer()
        } else {
            timerRunning = true
            let step: CGFloat = 0.01
            var currentTime: TimeInterval = 0

            Timer.scheduledTimer(withTimeInterval: step, repeats: true) { timer in
                currentTime += step
                progress = max(0, 1.0 - CGFloat(currentTime / duration))

                if currentTime >= duration {
                    timer.invalidate()
                    timerRunning = false
                }
            }
        }
    }

    func resetTimer() {
        progress = 1.0
        timerRunning = false
    }
}

#Preview {
    TimerBackground(duration: 10)
}
