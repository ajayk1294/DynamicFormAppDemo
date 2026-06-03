//
//  DynamicField.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

enum DynamicField: Identifiable {

    case text(TextFieldModel)
    case dropdown(DropdownFieldModel)
    case toggle(ToggleFieldModel)
    case checkbox(CheckboxFieldModel)

    var id: String {

        switch self {

        case .text(let model):
            return model.id

        case .dropdown(let model):
            return model.id

        case .toggle(let model):
            return model.id

        case .checkbox(let model):
            return model.id
        }
    }

    var order: Int {

        switch self {

        case .text(let model):
            return model.order

        case .dropdown(let model):
            return model.order

        case .toggle(let model):
            return model.order

        case .checkbox(let model):
            return model.order
        }
    }
}

extension DynamicField: Decodable {

    enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )

        let type = try container.decode(
            FieldType.self,
            forKey: .type
        )

        switch type {

        case .text:
            self = .text(
                try TextFieldModel(from: decoder)
            )

        case .dropdown:
            self = .dropdown(
                try DropdownFieldModel(from: decoder)
            )

        case .toggle:
            self = .toggle(
                try ToggleFieldModel(from: decoder)
            )

        case .checkbox:
            self = .checkbox(
                try CheckboxFieldModel(from: decoder)
            )
        }
    }
}
