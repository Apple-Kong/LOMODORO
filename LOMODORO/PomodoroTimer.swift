//
//  PomodoroTimer.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import AVFoundation
import SwiftUI

class PomodoroTimer: ObservableObject {
    enum TimerMode {
        case running
        case paused
        case initial
        case breakMode
    }

    @Published var mode: TimerMode = .initial
    @Published var secondsLeft = 1500 // 25 minutes
    @Published var showAlert = false

    var timer = Timer()
    var player: AVAudioPlayer?

    func startTimer() {
        self.mode = .running
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.secondsLeft == 0 {
                self.resetTimer()
                self.playSound()
                self.vibrate()
                self.showAlert = true
                self.mode = .breakMode
                self.secondsLeft = 300 // 5 minutes break
                return
            }
            self.secondsLeft -= 1
        }
    }

    func pauseTimer() {
        self.mode = .paused
        self.timer.invalidate()
    }

    func resetTimer() {
        self.mode = .initial
        self.secondsLeft = 1500 // 25 minutes
        self.timer.invalidate()
    }

    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        do {
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            self.player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func dismissAlert() {
        self.showAlert = false
    }

    var alert: Alert {
        Alert(title: Text("Time's up!"),
              message: Text("Your Pomodoro timer has finished."),
              dismissButton: .default(Text("OK"), action: self.dismissAlert))
    }
}


