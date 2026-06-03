//
//  TextFieldModel.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

struct TextFieldModel: Decodable, Identifiable {

    let id: String
    let order: Int
    let label: String
    let placeholder: String?
    let required: Bool
    let maxLength: Int?
    let errorMessage: String?
    let defaultValue: String?
    let regex: String?
    let subtype: TextSubtype

    enum CodingKeys: String, CodingKey {

        case id
        case order
        case label
        case placeholder
        case required

        case maxLength = "max_length"
        case errorMessage = "error_message"
        case defaultValue = "default_value"
        case regex
        case subtype
    }
}
