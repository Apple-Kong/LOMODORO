//
//  ContentView.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import SwiftUI

struct PomodoroCircleView: View {
    @State private var progress: Double = 0.0
    @State private var isRunning = false
    @State private var isBreak = false
    @Environment(\.scenePhase) private var scenePhase // scene phase
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            
            CircularProgressView(progress: progress)
                .padding(.horizontal, 20)
            
            VStack {
                Text("\(timeString(time: Int(25 * 60 - progress * 25 * 60)))")
                    .font(.system(size: 80))
                    .padding(.bottom, 40)
                
                HStack {
                    if !isRunning {
                        Button(action: startTimer) {
                            Text("Start")
                                .font(.system(size: 30))
                        }
                    } else {
                        Button(action: stopTimer) {
                            Text("Stop")
                                .font(.system(size: 30))
                        }
                        .padding(.horizontal, 20)
                        Button(action: resetTimer) {
                            Text("Reset")
                                .font(.system(size: 30))
                        }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                if progress < 1.0 {
                    progress += 1.0 / (25 * 60) // increment by 1 second
                } else {
                    // Timer finished, switch to break/work
                    isBreak.toggle()
                    if isBreak {
                        progress = 0.0
                    } else {
                        progress = 0.0
                    }
                }
            }
        }
        .onAppear {
            // Start with a work session
            progress = 0.0
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // Pause timer when app goes into the background
            stopTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Resume timer when app comes back into the foreground
            if scenePhase == .active {
                startTimer()
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            // Pause timer when app goes into the background
            if newScenePhase == .background {
                stopTimer()
            }
        }
    }
    
    func startTimer() {
        isRunning = true
    }
    
    func stopTimer() {
        isRunning = false
    }
    
    func resetTimer() {
        isRunning = false
        isBreak = false
        progress = 0.0
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct PomodoroCircleView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroCircleView()
    }
}
