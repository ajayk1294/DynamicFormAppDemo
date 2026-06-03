//
//  CheckboxRenderer.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct CheckboxRenderer: View {

    let model: CheckboxFieldModel

    @Binding var value: Bool

    let error: String?
    let theme: Theme
    
    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Button(action: {
                value.toggle()
            }) {

                HStack(alignment: .top, spacing: 12) {

                    Image(systemName:
                            value
                          ? "checkmark.square.fill"
                          : "square"
                    )
                    .foregroundColor(.blue)
                    .font(.title3)

                    Text(model.label)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    //checkboxText /*for metadata*/
                    Spacer()
                }
            }
            .buttonStyle(.plain)

            ValidationErrorView(
                error: error,
                color: Color(hex: theme.errorColor)
            )
        }
    }
    
//    
//    @ViewBuilder
//    private var checkboxText: some View {
//
//        if let metadata = model.metadata,
//           !metadata.isEmpty {
//
//            VStack(alignment: .leading, spacing: 4) {
//
//                Text(model.label)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.leading)
//
//                ForEach(
//                    metadata.keys.sorted(),
//                    id: \.self
//                ) { key in
//
//                    if let value = metadata[key],
//                       let url = URL(string: value) {
//
//                        Link(
//                            key,
//                            destination: url
//                        )
//                        .foregroundColor(
//                            Color(
//                                hex:
//                                model.clickableTextColor
//                                ?? "#2563EB"
//                            )
//                        )
//                    }
//                }
//            }
//
//        } else {
//
//            Text(model.label)
//                .foregroundColor(.white)
//                .multilineTextAlignment(.leading)
//        }
//    }
}
