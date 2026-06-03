//
//  DynamicFormView.swift
//  DynamicFormAppDemo
//
//  Created by Ajay on 31/05/26.
//

import SwiftUI


struct DynamicFormView: View {
    
    @StateObject private var viewModel = FormViewModel()
    
    var body: some View {
        
        Group {
            
            if let form = viewModel.form {
                
                ZStack {
                    
                    Color(hex: form.theme.backgroundColor)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 24) {
                            
                            Text(form.formTitle)
                                .font(.largeTitle.bold())
                                .foregroundColor(
                                    Color(hex: form.theme.textColor)
                                )
                            
                            ForEach(form.fields, id: \.id) { field in
                                
                                DynamicFieldView(
                                    field: field,
                                    viewModel: viewModel,
                                    theme: form.theme
                                )
                            }
                            
                            Button(action: {
                                
                                viewModel.submit()
                                
                            }) {
                                
                                Text("Save")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 14
                                        )
                                    )
                            }
                            .padding(.top, 12)
                        }
                        .padding()
                    }
                }
                
            } else {
                
                ProgressView()
            }
        }
        .preferredColorScheme(.light)
        .onAppear {

            viewModel.loadForm()
        }
        .alert(
            "Success",
            isPresented: $viewModel.showSuccessAlert
        ) {

            Button("OK", role: .cancel) { }

        } message: {

            Text(viewModel.successMessage)
        }
    }
}

#Preview {
    DynamicFormView()
}
