//
//  CheckboxFieldModel.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

struct CheckboxFieldModel: Decodable, Identifiable {

    let id: String
    let order: Int
    let label: String
    let required: Bool
    let errorMessage: String?
    let metadata: [String: String]?
    let clickableTextColor: String?

    enum CodingKeys: String, CodingKey {

        case id
        case order
        case label
        case required
        case metadata
        case clickableTextColor = "clickable_text_color"
        case errorMessage = "error_message"
    }
}
