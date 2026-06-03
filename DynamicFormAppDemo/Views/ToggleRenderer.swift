//
//  ToggleRenderer.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct ToggleRenderer: View {
    
    let model: ToggleFieldModel
    
    @Binding var value: Bool
    
    let error: String?
    let theme: Theme
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Toggle(isOn: $value) {
                
                Text(model.label)
                    .foregroundColor(.white)
                    .font(.body)
            }
            .tint(.green)
            
            ValidationErrorView(
                error: error,
                color: Color(hex: theme.errorColor)
            )
        }
    }
}
