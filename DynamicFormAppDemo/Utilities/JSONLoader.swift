//
//  JSONLoader.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

enum JSONLoader {

    static func load<T: Decodable>(_ fileName: String) throws -> T {

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "Missing JSON", code: 0)
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()

        return try decoder.decode(T.self, from: data)
    }
}
