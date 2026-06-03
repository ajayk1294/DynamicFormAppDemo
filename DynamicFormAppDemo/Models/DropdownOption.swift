//
//  DropdownOption.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

struct DropdownOption: Decodable, Identifiable {

    let id: String
    let label: String

    enum CodingKeys: String, CodingKey {
        case id
        case label
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )

        id = try container.decodeIfPresent(
            String.self,
            forKey: .id
        ) ?? UUID().uuidString

        label = try container.decodeIfPresent(
            String.self,
            forKey: .label
        ) ?? "Option"
    }
}
