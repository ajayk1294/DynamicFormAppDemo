//
//  ValidationErrorView.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct ValidationErrorView: View {
    
    let error: String?
    let color: Color
    
    var body: some View {
        
        if let error {
            
            Text(error)
                .font(.caption)
                .foregroundColor(color)
        }
    }
}
