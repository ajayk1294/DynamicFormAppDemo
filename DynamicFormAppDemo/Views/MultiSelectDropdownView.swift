//
//  MultiSelectDropdownView.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct MultiSelectDropdownView: View {

    let options: [DropdownOption]
    
    @Binding var value: FieldValue
    
    let theme: Theme

    var body: some View {

        VStack {

            if options.isEmpty {

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
                            .stroke(Color(hex: theme.borderColor), lineWidth: 1)
                    )

            } else {

                Menu {

                    ForEach(options) { option in

                        Button(action: {
                            toggle(option.id)
                        }) {

                            HStack {

                                Text(option.label)

                                if selections.contains(option.id) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }

                } label: {

                    HStack {

                        Text(displayText)
                            .foregroundColor(
                                selections.isEmpty ? .gray : .white
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
                            .stroke(Color(hex: theme.borderColor), lineWidth: 1)
                    )
                }
                .disabled(options.isEmpty)
            }
        }
    }

    private var selections: Set<String> {
        if case .multiSelection(let values) = value {
            return values
        }
        return []
    }

    private var displayText: String {
        let labels = options
            .filter { selections.contains($0.id) }
            .map(\.label)

        return labels.isEmpty ? "Select Options" : labels.joined(separator: ", ")
    }

    private func toggle(_ id: String) {

        var updated = selections

        if updated.contains(id) {
            updated.remove(id)
        } else {
            updated.insert(id)
        }

        value = .multiSelection(updated)
    }
}
