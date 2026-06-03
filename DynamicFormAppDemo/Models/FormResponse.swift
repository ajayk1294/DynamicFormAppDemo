//
//  FormResponse.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation


struct FormResponse: Decodable {
    
    let theme: Theme
    let formTitle: String
    let fields: [DynamicField]

    enum CodingKeys: String, CodingKey {

        case theme

        case formTitle = "form_title"

        case fields
    }

    init(
        theme: Theme,
        formTitle: String,
        fields: [DynamicField]
    ) {

        self.theme = theme

        self.formTitle = formTitle

        self.fields = fields
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )

        theme = try container.decode(
            Theme.self,
            forKey: .theme
        )

        formTitle = try container.decode(
            String.self,
            forKey: .formTitle
        )

        let safeFields = try container.decode(
            [SafeDynamicField].self,
            forKey: .fields
        )

        fields = safeFields.compactMap(\.field)
    }
}
