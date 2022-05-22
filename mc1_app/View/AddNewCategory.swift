//
//  AddNewTag.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 21/05/22.
//

import SwiftUI

struct AddNewCategory: View {
    // data from new list page
    @Binding var showCategoryForm: Bool
    @Binding var arrayCategory: [String]
    @Binding var arrayCategoryColor: [Color]
    
    @State var newCategory: String = ""
    @State var newTagColor: Color = Color.orange
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    TextField("New Category", text: $newCategory)
                        .disableAutocorrection(true)
                }
                Section {
                    HStack(spacing: 6) {
                        Rectangle()
                            .foregroundColor(newTagColor)
                            .cornerRadius(14)
                            .frame(width: 82, height: 82)
                            .onTapGesture {
                                // show color picker
                            }
                        Spacer()
                        
                        ColorPicker("Custom category tag color", selection: $newTagColor, supportsOpacity: false)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            // cancel button
                            showCategoryForm = false
                            
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                            
                        }
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            // Done button
                            print(newCategory)
                            print("\(newTagColor)")
                            arrayCategory.append(newCategory)
                            arrayCategoryColor.append(newTagColor)
                            
                            showCategoryForm = false
                            
                        } label: {
                            Text("Done")
                                .foregroundColor(newCategory != "" ? .blue : .secondary)
                        }
                    }
                }
                
                .navigationTitle("New Category")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

//struct AddNewTag_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        AddNewCategory()
//    }
//}


extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
