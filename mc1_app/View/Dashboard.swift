//
//  Dashboard.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 17/05/22.
//

import SwiftUI

struct Dashboard: View {
    @State private var searchQuery = ""
    
    @State var readingListManager = ReadingListManager()
   
    // reading form modal
    @State var showReadingForm: Bool = false
    
    
    // reading form
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookCategory: [String] = [""]
    
    let screenWidth = UIScreen.main.bounds.width
    
    
    init() {
        UITableView.appearance().sectionFooterHeight = 0
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if readingListManager.list.count == 0 {
                    VStack(alignment: .center) {
                        Spacer()
                            .frame(height: 100)
                        
                        Image("dashboard_image")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 255)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("\"they say Books can take you around the world, all you need to do Just Add it\"")
                            .font(.subheadline)
                            .padding(.horizontal, 30)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        //                    Button {
                        //                        // add reading list
                        //                        showReadingForm = true
                        //
                        //                    } label: {
                        //                        Text("Add Reading List")
                        //                            .padding(.horizontal, 20)
                        //                            .padding(.vertical, 12)
                        //                            .foregroundColor(.white)
                        //                            .background(Capsule())
                        //                    }
                    }
                } else {
                    List {
                        ForEach(readingListManager.list) { readingList in
                            let selectedId = readingList.id
                            let title: String = readingList.title
                            let author: String = readingList.author
                            let firstTag: String = readingList.category[0]
                            let firstTagColor: Color = readingList.categoryColor[0]
                            let numOfTag: Int = readingList.category.count
                            let insight: String = "You don't have any insight yet"
                            Section {
                                BookCardView(bookTitle: title, bookAuthor: author, firstTag: firstTag, firstTagColor: firstTagColor, numOfTag: numOfTag, insight: insight)
                                    .padding(.vertical, 16)
                            }
                            .frame(height: 200)
                            .overlay(
                                NavigationLink(destination: ReadingDetail(readingListManager: $readingListManager, selectedListId: selectedId, selectedItem: readingList), label: {
                                    EmptyView()
                                })
                            )
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Reading List")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Sort item button pressed")
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // ketika di klik
                        showReadingForm.toggle()
                    } label: {
                        Text("Add")
                            .font(.title3)
                    }
                }
            }
        }
        .sheet(isPresented: $showReadingForm) {
            ReadingForm(showReadingForm: $showReadingForm, readingListManager: $readingListManager, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookCategory: $bookCategory)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

//struct ExtractedView: View {
//    var body: some View {
//        HStack {
//            Image("average-dev")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 70)
//                .cornerRadius(4)
//            VStack (alignment: .leading){
//                Text("I'm an average developer 💡")
//                    .fontWeight(.semibold)
//                    .font(.body)
//                    .lineLimit(2)
//                    .minimumScaleFactor(0.5)
//                
//                Text("January 1, 2022")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                
//            }
//        }
//    }
//}


