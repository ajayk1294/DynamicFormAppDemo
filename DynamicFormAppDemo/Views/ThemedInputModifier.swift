//
//  ThemedInputModifier.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct ThemedInputModifier: ViewModifier {
    
    let theme: Theme
    let hasError: Bool
    
    func body(content: Content) -> some View {
        
        content
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        hasError
                        ? Color(hex: theme.errorColor)
                        : Color(hex: theme.borderColor),
                        lineWidth: 1
                    )
            )
    }
}

extension View {
    
    func themedInput(
        theme: Theme,
        hasError: Bool = false
    ) -> some View {
        
        modifier(
            ThemedInputModifier(
                theme: theme,
                hasError: hasError
            )
        )
    }
}
