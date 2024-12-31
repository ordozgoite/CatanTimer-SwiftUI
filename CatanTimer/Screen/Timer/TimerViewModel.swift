//
//  TimerViewModel.swift
//  CatanTimer
//
//  Created by Victor Ordozgoite on 29/12/24.
//

import Foundation
import AVFoundation

@MainActor
class TimerViewModel: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    
    @Published var diceThrown: Bool = false
    @Published var whiteDieNumber: Int = 1
    @Published var redDieNumber: Int = 1
    
    @Published var timerProgress: CGFloat = 1.0
    @Published var isTimerRunning: Bool = false
    
    private var timer: Timer?
    
    func throwDice() {
        self.whiteDieNumber = generateDieNumber()
        self.redDieNumber = generateDieNumber()
        self.diceThrown = true
        
        playAudio(withName: "roll-dice-sound", andEnxtension: "m4a")
    }
    
    private func generateDieNumber() -> Int {
        return Int.random(in: 1...6)
    }
    
    func endTurn(startNewTimer: () -> ()) {
        resetTimer()
        self.diceThrown = false
        startNewTimer()
    }
    
    func startTimer(withDuration duration: Double) {
        timer?.invalidate()
        
        self.isTimerRunning = true
        self.timerProgress = 1.0
        let step: CGFloat = 0.01
        var currentTime: TimeInterval = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: step, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            currentTime += step
            self.timerProgress = max(0, 1.0 - CGFloat(currentTime / duration))
            
            if currentTime >= duration {
                timer.invalidate()
                self.isTimerRunning = false
            }
        }
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timerProgress = 1.0
        isTimerRunning = false
    }
    
    private func playAudio(withName audioName: String, andEnxtension audioExtension: String) {
        if let soundURL = Bundle.main.url(forResource: audioName, withExtension: audioExtension) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing dice roll sound: \(error.localizedDescription)")
            }
        } else {
            print("Dice roll sound file not found.")
        }
    }
}
