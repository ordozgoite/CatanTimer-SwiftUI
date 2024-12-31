//
//  MenuScreen.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 27/12/24.
//

import SwiftUI

struct MenuScreen: View {
    
    @State private var selectedTime: Double = 60.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Catan Timer\n🪵🧱🐑🌽🪨")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    TimerSettings()
                    
                    Spacer()
                    
                    StartButton()
                }
                .padding()
            }
        }
    }
    
    // MARK: Timer Settings
    
    @ViewBuilder
    private func TimerSettings() -> some View {
        Text("Duração do turno:")
            .font(.title3)
        
        Slider(value: $selectedTime, in: 30...300, step: 1)
            .accentColor(.blue)
        
        Text("\(Int(selectedTime / 60)) min \(Int(selectedTime.truncatingRemainder(dividingBy: 60))) seg")
            .font(.headline)
    }
    
    // MARK: Start Button
    
    @ViewBuilder
    private func StartButton() -> some View {
        NavigationLink {
            TimerScreen(timerDuration: self.selectedTime)
        } label: {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .fill(.blue)
                    .frame(width: 300, height: 60, alignment: .center)
                
                Text("Start")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(width: 256, height: 40, alignment: .center)
            }
        }
    }
}

#Preview {
    MenuScreen()
}
