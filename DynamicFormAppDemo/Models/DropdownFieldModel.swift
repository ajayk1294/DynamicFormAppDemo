//
//  DropdownFieldModel.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

struct DropdownFieldModel: Decodable, Identifiable {

    let id: String
    let order: Int
    let label: String
    let required: Bool
    let allowMultiple: Bool
    let defaultValues: [String]
    let options: [DropdownOption]
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {

        case id
        case order
        case label
        case required
        case allowMultiple = "allow_multiple"
        case defaultValues = "default_values"
        case options
        case errorMessage = "error_message"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )

        id = try container.decode(
            String.self,
            forKey: .id
        )

        order = try container.decodeIfPresent(
            Int.self,
            forKey: .order
        ) ?? 0

        label = try container.decodeIfPresent(
            String.self,
            forKey: .label
        ) ?? "Dropdown"

        required = try container.decodeIfPresent(
            Bool.self,
            forKey: .required
        ) ?? false

        allowMultiple = try container.decodeIfPresent(
            Bool.self,
            forKey: .allowMultiple
        ) ?? false

        defaultValues = try container.decodeIfPresent(
            [String].self,
            forKey: .defaultValues
        ) ?? []

        options = try container.decodeIfPresent(
            [DropdownOption].self,
            forKey: .options
        ) ?? []

        errorMessage = try container.decodeIfPresent(
            String.self,
            forKey: .errorMessage
        )
    }
}
