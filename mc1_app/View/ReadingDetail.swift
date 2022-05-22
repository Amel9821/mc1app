//
//  ReadingDetail.swift
//  mc1_app
//
//  Created by Ricky Silitonga on 17/05/22.
//

import SwiftUI

struct ReadingDetail: View {
    @Environment(\.colorScheme) var colorScheme
    
    // binding data from dashboard
    @Binding var readingListManager: ReadingListManager
    
    let selectedListId: UUID
    let selectedItem: ReadingListModel
    
    @State var buttonAddPurposeTapped = false
    @State var editQuotes = false
    @State var editAT = false
    @State var editPurpose = true
    
    @State var purposeText : String = ""
    @State var quoteArray = [String]()
    @State var actionArray = [String]()
    var purposePlaceholder: String = "Add purpose"
    //    @Binding var readingList: ReadingList
    
    var selectedIndex: Int {
        let index = readingListManager.getIndex(id: selectedListId)
        
        return index
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(readingListManager.getReadingListByIndex(index: selectedIndex).title)
                    .font(.title2)
                    .padding(.top, 10)
                
                
                Text(readingListManager.getReadingListByIndex(index: selectedIndex).author)
                    .font(.subheadline)
                
                HStack {
                    TagViewPlacement(items: readingListManager.getReadingListByIndex(index: selectedIndex).category, color: readingListManager.getReadingListByIndex(index: selectedIndex).categoryColor)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 100)
            .padding(.bottom, 5)
            .clipShape(Rectangle())
            
            .background(colorScheme == .light ? .white : .black)
            .cornerRadius(14)
            .shadow(color: .gray.opacity(0.4), radius: 1, x: 1, y: 2)
            
            List {
                Section(header: HeaderPurpose(purposeText: $purposeText, buttonAddPurposeTapped: $buttonAddPurposeTapped, editPurpose: $editPurpose)) {
                    if editPurpose && buttonAddPurposeTapped {
                        ZStack (alignment: .leading) {
                            if purposeText.isEmpty {
                                Text ("Add purpose")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            TextEditor (text: $purposeText)
                        }
                    } else {
                        if purposeText != "" {
                            Text(purposeText)
                        } else {
                            Button(action: {
                                self.buttonAddPurposeTapped = true
                            }, label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                        .foregroundColor(.green)
                                    Text("Add Purpose")
                                        .font(.body)
                                }
                            })
                        }
                    }
                } .textCase(nil)
                
                
                Section(header: HeaderQuotes(quoteArray: $quoteArray, editQuotes: $editQuotes)) {
                    //                    HStack {
                    // var mie = ['indomie', "mie sedap", "maggi"]
                    // mie.indices = [0,1,2]
                    ForEach(quoteArray.indices, id:\.self) { index in
                        ZStack(alignment: .leading) {
                            if quoteArray[index].isEmpty {
                                ZStack {
                                    Text ("Add quotes \(index+1)")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                            }
                            if editQuotes {
                                TextEditor(text: $quoteArray[index])
                                    .disableAutocorrection(true)
                                //                                    .swipeActions {
                                //                                        Button {
                                //                                            quoteArray.remove(at: index)
                                //                                        } label: {
                                //                                            Text("Delete")
                                //                                        }
                                //                                        .tint(.red)
                                //                                    }
                            } else {
                                Text(quoteArray[index])
//                                    .swipeActions {
//                                        Button {
//                                            quoteArray.remove(at: index)
//                                        } label: {
//                                            Text("Delete")
//                                        }
//                                        .tint(.red)
//                                    }
//                                    .listRowBackground(Color.red)
                            }
                        }
                        .swipeActions {
                            Button {
                                quoteArray.remove(at: index)
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                        .listRowBackground(editQuotes ? Color.white : Color.gray.opacity(0.5))
                    }
                    Button(action: {
                        withAnimation {
                            //                            if(quoteArray.count < 3) {
                            quoteArray.append("")
                            //                            }
                            editQuotes.toggle()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundColor(.green)
                            Text("Add Quotes")
                                .font(.body)
                        }
                    })
                } .textCase(nil)
                
                Section(header: HeaderAction(actionArray: $actionArray, editAT: $editAT)) {
                    ForEach(actionArray.indices, id:\.self) {
                        idx in
                        ZStack(alignment: .leading) {
                            if actionArray[idx].isEmpty {
                                Text ("Add actionable takeaways \(idx+1)")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            if editAT {
                                TextEditor(text: $actionArray[idx])
                                    .disableAutocorrection(true)
                                    .swipeActions {
                                        Button {
                                            quoteArray.remove(at: idx)
                                        } label: {
                                            Text("Delete")
                                        }
                                        .tint(.red)
                                    }
                            } else {
                                Text(actionArray[idx])
                            }
                        }
                    }
                    Button(action: {
                        withAnimation {
                            //                            if(quoteArray.count < 3) {
                            actionArray.append("")
                            editAT.toggle()
                            
                            //                            }
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundColor(.green)
                            Text("Add Action")
                                .font(.body)
                        }
                    })
                    
                } .textCase(nil)
                    .listStyle(.insetGrouped)
            }
            .listRowBackground(Color.red)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}



struct HeaderPurpose : View {
    
    @Binding var purposeText: String
    @Binding var buttonAddPurposeTapped: Bool
    @Binding var editPurpose : Bool
    
    var body : some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Purpose")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer ()
                Button  {
                    editPurpose.toggle()
                    if editPurpose == false {
                        print(editPurpose)
                        
                    }
                    
                } label: {
                    if editPurpose {
                        Image (systemName: "checkmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.blue)
                    } else {
                        Text("Edit")
                            .frame(height: 16)
                            .font(.body)
                    }
                }
                .opacity(purposeText == "" ? 0 : 1)
            }
            Text ("This is the reason why I read this book")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
}



struct HeaderQuotes : View {
    
    @Binding var quoteArray : [String]
    @Binding var editQuotes: Bool
    
    
    var body : some View {
        VStack (alignment: .leading, spacing: 3) {
            HStack {
                Text("Quote")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer ()
                Button  {
                    editQuotes.toggle()
                } label: {
                    if editQuotes {
                        Image (systemName: "checkmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.blue)
                    } else {
                        Text("Edit")
                            .font(.body)
                    }
                }
                .opacity(quoteArray.isEmpty ? 0 : 1)
                //                    .opacity(quoteArray == "" ? 0 : 1)
            }
            Text ("These are quotes that you get from the book")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}



struct HeaderAction : View {
    
    @Binding var actionArray : [String]
    @Binding var editAT: Bool
    
    var body : some View {
        VStack (alignment: .leading, spacing: 3) {
            HStack {
                Text("Actionable Takeaways")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer ()
                Button  {
                    editAT.toggle()
                } label: {
                    if editAT {
                        Image (systemName: "checkmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.blue)
                    } else {
                        Text("Edit")
                            .font(.body)
                    }
                }
                .opacity(actionArray.isEmpty ? 0 : 1)
            }
            Text ("These are learning points you took from the book that suits your purpose and converted into the real-life interpretation")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

//struct ReadingDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ReadingDetail()
//    }
//}
