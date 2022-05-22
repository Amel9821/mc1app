//
//  ReadingListEdit.swift
//  mc1_app
//
//  Created by Amalia . on 22/05/22.
//

import SwiftUI

struct ReadingListEdit: View {
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    //@Binding var ReadingList : ReadingListModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Title..", text: $bookTitle)
                    TextField("Author", text: $bookAuthor)
                }
                
                // category
                Section {
                    VStack(alignment: .leading) {
                        Text("Category")
                            .font(.title3)
                        HStack {
                            TagView(tagText: "Financial", tagColor: .secondary)
                            TagView(tagText: "Self-Improvement", tagColor: .secondary)
                            
                        }
                    } .padding(.vertical)
                }
                
                
                Section {
                    Button {
                        // add photo
                    } label: {
                        Text("Add Book Cover Image")
                            .font(.body)
                    }
                }
            }
            .navigationTitle("Edit Reading Description")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        // cancel button
//                        showReadingForm.toggle()
                        
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // Done button
//                        if formIsDone {
//                            print("baru bisa done setelah title dan author di klik")
//                            showReadingForm.toggle()
                        }
                    label: {
                        Text("Done")
//                            .foregroundColor(formIsDone ? .blue : .secondary)
                    }
                }
            }
            
        }
    }
}

struct ReadingListEdit_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListEdit()
    }
}
