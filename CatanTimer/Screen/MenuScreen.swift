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
        VStack {
            Text("Catan Timer\n🪵🧱🐑🌽🪨")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            TimerSettings()
            
            Spacer()
            
            Button("Start") {
                // start
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
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
}

#Preview {
    MenuScreen()
}
