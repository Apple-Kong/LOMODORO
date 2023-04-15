//
//  RoundedButton.swift
//  LOMODORO
//
//  Created by GOngTAE on 2023/04/15.
//

import SwiftUI

struct RoundedButton: View {
    let buttonTitle: String
    let buttonColor: Color
    let textColor: Color
    let action: () -> Void
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .frame(minWidth: 100, maxWidth: .infinity)
                .frame(minHeight: 60, idealHeight: 60, maxHeight: 70)
                .background(buttonColor)
                .cornerRadius(cornerRadius)
        }
    }
}


struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(buttonTitle: "테스트", buttonColor: .primary, textColor: .white, action: {})
    }
}
