//
//  FieldType.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

enum FieldType: String, Decodable {

    case text = "TEXT"
    case dropdown = "DROPDOWN"
    case toggle = "TOGGLE"
    case checkbox = "CHECKBOX"
}


struct SafeDynamicField: Decodable {

    let field: DynamicField?

    init(from decoder: Decoder) throws {

        do {

            field = try DynamicField(from: decoder)

        } catch {

            print("Skipping malformed field: \(error)")

            field = nil
        }
    }
}
