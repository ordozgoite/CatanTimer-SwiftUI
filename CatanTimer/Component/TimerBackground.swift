//
//  TimerBackground.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 28/12/24.
//

import SwiftUI

struct TimerBackground: View {
    
    var duration: TimeInterval
    
    @Binding var progress: CGFloat
    @Binding var timerRunning: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .fill(progress < 0.25 ? .red : .green)
                .frame(height: UIScreen.main.bounds.height)
                .offset(y: UIScreen.main.bounds.height * (1 - progress))
                .animation(.easeInOut(duration: 0.1), value: progress)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TimerBackground(duration: 10, progress: .constant(1.0), timerRunning: .constant(false))
}
