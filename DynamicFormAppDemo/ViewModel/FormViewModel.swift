//
//  FormViewModel.swift
//  DynamicFormAppDemo
//

import SwiftUI
import Combine

@MainActor
final class FormViewModel: ObservableObject {
    
    @Published var form: FormResponse?
    @Published var values: [String: FieldValue] = [:]
    @Published var errors: [String: String] = [:]
    @Published var showSuccessAlert = false
    @Published var successMessage = ""
    
    func loadForm() {
        
        do {
            
            let response: FormResponse =
            try JSONLoader.load("form")
            
            self.form = FormResponse(theme: response.theme,
                                     formTitle: response.formTitle,
                                     fields: response.fields.sorted {($0.order, $0.id) < ($1.order, $1.id)}
            )
            
            setupDefaultValues()
            
        } catch {
            
            print("Failed to load form: \(error)")
        }
    }
    
    
    private func setupDefaultValues() {
        
        guard let form else { return }
        
        for field in form.fields {
            
            switch field {
                
            case .text(let model):
                
                let text =
                model.defaultValue ?? ""
                
                let limitedText = String( text.prefix( model.maxLength ?? Int.max))
                
                values[model.id] = .text(limitedText)
                
            case .dropdown(let model):
                
                
                if model.options.isEmpty {     // Empty options -> skip validation
                    
                    values[model.id] = .empty
                    
                    continue
                }
                
                if model.allowMultiple {
                    
                    values[model.id] = .multiSelection(Set(model.defaultValues))
                    
                } else {
                    
                    values[model.id] = .singleSelection(model.defaultValues.first ?? "")
                }
                
                
            case .toggle(let model):
                
                values[model.id] = .bool(model.defaultValue ?? false)
                
            case .checkbox(let model):
                
                values[model.id] = .bool(false)
            }
        }
        
       // print("DEFAULT VALUES:", values)
        print(values)
    }
    
    
    func validate() -> Bool {
        
        guard let form else { return false }
        
        errors.removeAll()
        
        for field in form.fields {
            
            ValidationEngine.validate(field: field,values: values,errors: &errors)
        }
        
      //  print("VALIDATION ERRORS:", errors)
        print(values)
        
        return errors.isEmpty
    }
    
    func submit() {

        print("SAVE BUTTON CLICKED")

        let isValid = validate()

        print("IS VALID:", isValid)

        print("VALUES:", values)

        print("ERRORS:", errors)

        guard isValid else {

            print("VALIDATION FAILED")

            return
        }

        print("SUCCESS PAYLOAD:")

        print(payload)

        successMessage = "Form submitted successfully!"

        showSuccessAlert = true
    }
    
    var payload: [String: Any] {
        
        var result: [String: Any] = [:]
        
        for (key, value) in values {
            
            switch value {
                
            case .text(let text):
                
                result[key] = text
                
            case .bool(let bool):
                
                result[key] = bool
                
            case .singleSelection(let selection):
                
                result[key] = selection
                
            case .multiSelection(let selections):
                
                result[key] = Array(selections)
                
            case .empty:
                
                continue
            }
        }
        
        return result
    }
    
    func updateValue(_ value: FieldValue,for id: String) {
        
        DispatchQueue.main.async {
            
            self.values[id] = value
            
            self.errors[id] = nil
            
            print("UPDATED:", id)
        }
    }
}
