//
//  FieldValue.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import Foundation

enum FieldValue {

    case text(String)
    case bool(Bool)
    case singleSelection(String)
    case multiSelection(Set<String>)
    case empty
}
