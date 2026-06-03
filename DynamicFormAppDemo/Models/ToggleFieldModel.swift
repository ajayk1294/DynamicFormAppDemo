//
//  ToggleFieldModel.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

struct ToggleFieldModel: Decodable, Identifiable {
    
    let id: String
    let order: Int
    let label: String
    let required: Bool
    let defaultValue: Bool?

    enum CodingKeys: String, CodingKey {

        case id
        case order
        case label
        case required
        case defaultValue = "default_value"
    }
}
