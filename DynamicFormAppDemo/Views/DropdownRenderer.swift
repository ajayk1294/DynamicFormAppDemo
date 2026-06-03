//
//  DropdownRenderer.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct DropdownRenderer: View {

    let model: DropdownFieldModel

    @Binding var value: FieldValue

    let error: String?
    let theme: Theme

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(model.label)
                .foregroundColor(.white)
                .font(.headline)

            if model.options.isEmpty {

                Text("No options available")
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.08))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                Color(hex: theme.borderColor),
                                lineWidth: 1
                            )
                    )

            } else if model.allowMultiple {

                MultiSelectDropdownView(
                    options: model.options,
                    value: $value,
                    theme: theme
                )

            } else {

                Menu {

                    ForEach(model.options) { option in

                        Button {

                            value = .singleSelection(option.id)

                        } label: {

                            HStack {

                                Text(option.label)

                                if selectedId == option.id {

                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }

                } label: {

                    HStack {

                        Text(selectedText)
                            .foregroundColor(
                                selectedId.isEmpty
                                ? .gray
                                : .white
                            )

                        Spacer()

                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.08))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                Color(hex: theme.borderColor),
                                lineWidth: 1
                            )
                    )
                }
            }

            ValidationErrorView(
                error: error,
                color: Color(hex: theme.errorColor)
            )
        }
    }


    private var selectedId: String {

        if case .singleSelection(let id) = value {
            return id
        }

        return ""
    }

    private var selectedText: String {

        model.options.first(where: {
            $0.id == selectedId
        })?.label ?? "Select Option"
    }
}
