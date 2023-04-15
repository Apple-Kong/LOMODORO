//
//  Color.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
    
    static let background = Color(hex: "F9F5EB")
    static let primary = Color(hex: "EA5455")
    static let tint = Color(hex: "002B5B")
}

