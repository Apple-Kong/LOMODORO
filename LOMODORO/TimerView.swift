//
//  ContentView.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import SwiftUI
import Combine
import AudioToolbox

struct PomodoroCircleView: View {
    @ObservedObject var timer = PomodoroTimer()
    
    var body: some View {
        ZStack {
            
            Color.background
                .ignoresSafeArea()
            
            VStack {
                CircularProgressView(progress: Double(1500 - self.timer.secondsLeft) / 1500.0)
                    .padding(.horizontal, 40)
            }
            
            Text("\(Int(25 * 60 - Double(1500 - self.timer.secondsLeft) / 1500.0 * 25 * 60).timeString())")
                .font(.system(size: 60))
            
            VStack {
            
                Spacer()
                
                HStack {
                    Button(action: {
                        if self.timer.mode == .initial {
                            self.timer.startTimer()
                        } else if self.timer.mode == .paused {
                            self.timer.startTimer()
                        } else if self.timer.mode == .running {
                            self.timer.pauseTimer()
                        }
                    }) {
                        Image(systemName: self.timer.mode == .running ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .tint(Color.primary)
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                    
                    Button(action: {
                        self.timer.resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .tint(.tint)
                            .frame(width: 50, height: 50)
                    }
                    
                }
                .padding(20)
            }
        }
    }
}

struct PomodoroCircleView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroCircleView()
    }
}
