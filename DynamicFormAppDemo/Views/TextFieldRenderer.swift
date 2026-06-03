//
//  TextFieldRenderer.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct TextFieldRenderer: View {

    let model: TextFieldModel

    @Binding var value: FieldValue

    let error: String?
    let theme: Theme


    private var text: Binding<String> {

        Binding<String>(

            get: {

                if case .text(let currentValue) = value {

                    return currentValue
                }

                return ""
            },

            set: { newValue in

                let max = model.maxLength ?? Int.max

                let limitedText = String(
                    newValue.prefix(max)
                )

                if case .text(let current) = value {

                    if current != limitedText {

                        value = .text(limitedText)
                    }

                } else {

                    value = .text(limitedText)
                }
            }
        )
    }


    var body: some View {

        VStack(alignment: .leading, spacing: 8) {


            Text(model.label)
                .foregroundColor(
                    Color(hex: theme.textColor)
                )
                .font(.headline)

            inputField


            if let max = model.maxLength {

                HStack {

                    Spacer()

                    Text(
                        "\(text.wrappedValue.count)/\(max)"
                    )
                    .font(.caption)
                    .foregroundColor(
                        text.wrappedValue.count >= max
                        ? .red
                        : .gray
                    )
                }
            }

    
            ValidationErrorView(
                error: error,
                color: Color(hex: theme.errorColor)
            )
        }
    }

    
    @ViewBuilder
    private var inputField: some View {

        switch model.subtype {
            
        case .plain:

            TextField(
                "",
                text: text,
                prompt: Text(model.placeholder ?? "")
                    .foregroundColor(.gray)
            )
            .themedInput(
                theme: theme,
                hasError: error != nil
            )


        case .multiline:

            TextEditor(text: text)

                .onChange(of: text.wrappedValue) {

                    let max = model.maxLength ?? Int.max

                    if text.wrappedValue.count > max {

                        text.wrappedValue = String(
                            text.wrappedValue.prefix(max)
                        )
                    }
                }

                .frame(minHeight: 120)

                .themedInput(
                    theme: theme,
                    hasError: error != nil
                )


        case .number:

            TextField(
                "",
                text: text,
                prompt: Text(model.placeholder ?? "")
                    .foregroundColor(.gray)
            )
            .keyboardType(.decimalPad)

            .themedInput(
                theme: theme,
                hasError: error != nil
            )

        case .uri:

            TextField(
                "",
                text: text,
                prompt: Text(model.placeholder ?? "")
                    .foregroundColor(.gray)
            )
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            .themedInput(
                theme: theme,
                hasError: error != nil
            )


        case .secure:

            SecureField(
                model.placeholder ?? "",
                text: text
            )

            .themedInput(
                theme: theme,
                hasError: error != nil
            )
        }
    }
}



