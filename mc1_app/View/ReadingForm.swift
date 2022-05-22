//
//  ReadingForm.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 20/05/22.
//

import SwiftUI

struct ReadingForm: View {
    @Binding var showReadingForm: Bool
    @Binding var readingListManager: ReadingListManager
    
    // data
    @Binding var bookTitle: String
    @Binding var bookAuthor: String
    @Binding var bookCategory: [String]
    
    @State var exampleTag:[String] = []
    @State var exampleColor: [Color] = []
    
    @State var addNewTag: Bool = false
    @State var showCategoryForm: Bool = false
    
    var formIsDone: Bool {
        if bookTitle != "" && bookAuthor != "" && !exampleTag.isEmpty {
            return true
        } else {
            return false
        }
        
    }
//    self.init(UITableView.appearance().sectionFooterHeight = 0)
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Title..", text: $bookTitle)
                        .disableAutocorrection(true)
                    TextField("Author", text: $bookAuthor)
                        .disableAutocorrection(true)
                }
                
                // category
                Section {
                    VStack(alignment: .leading) {
                        Text("Category")
                            .font(.title3)
                        VStack(alignment: .leading, spacing: 10) {
                                
                            // create tag view here
                            TagViewPlacement(items: exampleTag, color: exampleColor)
                            
                            Button {
                                // add new tag
                                showCategoryForm = true
                                print("Add new tag")
                            } label: {
                                HStack(spacing: 0) {
                                    Image(systemName: "plus")
                                    Text("New Category")
                                        .foregroundColor(.blue)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                } .padding(.horizontal, 8)
                            } .background(Capsule().fill(.secondary).opacity(0.6))
                            
                            
                        }
                    } .padding(.vertical)
                }
                
                // add photo section
                Section {
                    Button {
                        // add photo
                    } label: {
                        Text("Add Book Cover Image")
                            .font(.body)
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        // cancel button
                        showReadingForm.toggle()
                        
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Done button
                        if formIsDone {
                            print("baru bisa done setelah title dan author di klik")
                            let newReadingList: ReadingListModel = ReadingListModel(title: bookTitle, author: bookAuthor, category: exampleTag, categoryColor: exampleColor)
                            
                            readingListManager.list.append(newReadingList)
                            showReadingForm.toggle()
                            bookTitle = ""
                            bookAuthor = ""
                            
                            print(newReadingList)
                        }
                        
                    } label: {
                        Text("Done")
                            .foregroundColor(formIsDone ? .blue : .secondary)
                    }
                }
            }
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showCategoryForm) {
                AddNewCategory(showCategoryForm: $showCategoryForm, arrayCategory: $exampleTag, arrayCategoryColor: $exampleColor)
            }
            
        }
    }
}

//struct ReadingForm_Previews: PreviewProvider {
//    @State var showReadingForm: Bool = true
//    @State var readingListManager: ReadingListManager = ReadingListManager(readingLists: [ReadingListModel(title: "Test", author: "Test")])
//    @State var bookTitle: String = ""
//    @State var bookAuthor: String = ""
//    @State var bookCategory: String = ""
//
//    static var previews: some View {
//        ReadingForm(showReadingForm: $showReadingForm, readingListManager: <#T##Binding<ReadingListManager>#>, bookTitle: <#T##Binding<String>#>, bookAuthor: <#T##Binding<String>#>, bookCategory: <#T##Binding<String>#>)
//    }
//}
