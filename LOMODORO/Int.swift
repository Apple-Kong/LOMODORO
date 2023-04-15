//
//  Int.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import Foundation

extension Int {
    func timeString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
