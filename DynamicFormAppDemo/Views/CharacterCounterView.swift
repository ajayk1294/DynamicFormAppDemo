//
//  CharacterCounterView.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct CharacterCounterView: View {
    
    let current: Int
    let max: Int
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text("\(current)/\(max)")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
