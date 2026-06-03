//
//  ValidationEngine.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

enum ValidationEngine {

    static func validate(field: DynamicField,values: [String: FieldValue],
                         errors: inout [String: String]) {

        switch field {

        case .text(let model):

            guard case .text(let textValue) = values[model.id] else {
                return
            }

            if model.required &&
                textValue
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty {

                errors[model.id] =
                    model.errorMessage ?? "Required field"

                return
            }

            if let maxLength = model.maxLength,textValue.count > maxLength {

                errors[model.id] =
                    "Maximum length is \(maxLength)"
            }

            if let regex = model.regex,!textValue.isEmpty,textValue.range(
                    of: regex,options: .regularExpression) == nil {

                errors[model.id] = "Invalid format"
            }

        case .dropdown(let model):

            if model.options.isEmpty {
                return
            }

            if model.allowMultiple {

                guard case .multiSelection(let selections)
                        = values[model.id] else {
                    return
                }

                if model.required && selections.isEmpty {

                    errors[model.id] = model.errorMessage ?? "Please select at least one option"
                }

            } else {

                guard case .singleSelection(let selection)
                        = values[model.id] else {
                    return
                }

                if model.required && selection.isEmpty {

                    errors[model.id] = model.errorMessage ?? "Please select an option"
                }
            }

        case .toggle(let model):

            guard case .bool(let value) = values[model.id] else {
                return
            }

            if model.required && value == false {

                errors[model.id] = "This field is required"
            }

        case .checkbox(let model):

            guard case .bool(let value) = values[model.id] else {
                return
            }

            if model.required && value == false {

                errors[model.id] = model.errorMessage ?? "This field is required"
            }
        }
    }
}
