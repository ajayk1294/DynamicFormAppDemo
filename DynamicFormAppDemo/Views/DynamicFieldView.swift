//
//  DynamicFieldView.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI

struct DynamicFieldView: View {

    let field: DynamicField

    @ObservedObject var viewModel: FormViewModel

    let theme: Theme

    var body: some View {

        switch field {

        case .text(let model):

            TextFieldRenderer(
                model: model,
                value: binding(for: model.id),
                error: viewModel.errors[model.id],
                theme: theme
            )


        case .dropdown(let model):

            DropdownRenderer(
                model: model,
                value: binding(for: model.id),
                error: viewModel.errors[model.id],
                theme: theme
            )

        case .toggle(let model):

            ToggleRenderer(
                model: model,
                value: boolBinding(for: model.id),
                error: viewModel.errors[model.id],
                theme: theme
            )

        case .checkbox(let model):

            CheckboxRenderer(
                model: model,
                value: boolBinding(for: model.id),
                error: viewModel.errors[model.id],
                theme: theme
            )

        }
    }



    private func binding(for id: String) -> Binding<FieldValue> {

        Binding(

            get: {

                viewModel.values[id] ?? .empty
            },

            set: {

                viewModel.updateValue($0, for: id)
            }
        )
    }

    private func boolBinding(for id: String) -> Binding<Bool> {

        Binding(

            get: {

                if case .bool(let value) = viewModel.values[id] {

                    return value
                }

                return false
            },

            set: {

                viewModel.updateValue(
                    .bool($0),
                    for: id
                )
            }
        )
    }
}
