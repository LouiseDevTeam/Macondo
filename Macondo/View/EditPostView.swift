//
//  EditPostView.swift
//  Macondo
//
//  Created by Louis Shen on 2021/1/2.
//

import Foundation
import SwiftUI

struct EditPostView : View{
    @EnvironmentObject var showView : ViewNavigation
    
    @State var title : String = ""
    @State var text : String = ""
    @State var image : String = ""
    @State var summary : String = ""
    @State var category : String = ""
    @State var tag : String = ""
    
    var cid : Int = 0
    
    init(cid : Int, language : String) {
        let pd : PostData = Sqlite.getPostData(cidd: cid, language: language)
        self.cid = cid
        _title = State(initialValue: pd.getTitle())
        _text = State(initialValue: pd.getText())
        _image = State(initialValue: pd.getThumbUrl())
        _summary = State(initialValue: pd.getSummary())
        _category = State(initialValue: pd.getCategory())
        _tag = State(initialValue: pd.getTag())
    }
    
    var body : some View {
        VStack {
            HStack {
                VStack {
                    TextField(T.me(t: "Add title", language: self.showView.lang),text: $title)//.textFieldStyle(RoundedBorderTextFieldStyle())
                    TextEditor(text: $text)
                }
                VStack {
                    HStack {
                        Text(T.me(t: "Category: ", language: self.showView.lang))
                        TextField("", text: $category)
                    }
                    HStack {
                        Text(T.me(t: "Tag: ", language: self.showView.lang))
                        TextField("", text: $tag)
                    }
                    Text(T.me(t: "Custom YAML", language: self.showView.lang))
                    TextEditor(text: $image)
                }
            }
            HStack {
                Text(T.me(t: "Summary: ", language: self.showView.lang))
                TextField("",text: $summary)
            }
            Spacer()
            HStack {
                Button(action: {
                    self.showView.showView = 0
                }) {
                    Text(T.me(t: "Cancel", language: self.showView.lang))
                }
                
                Button(action: {
                    Sqlite.deletePost(cidd: self.cid, language: self.showView.lang)
                    self.showView.showView = 0
                }) {
                    Text(T.me(t: "Delete", language: self.showView.lang))
                    .foregroundColor(Color.red)
                    .bold()
                }
                
                Button(action: {
                    Sqlite.editPost(cidd: self.cid,title: self.title, text: self.text, thumbUrl: self.image, summary: self.summary, category: self.category, tag: self.tag,language: self.showView.lang)
                    self.showView.showView = 0
                }) {
                    Text(T.me(t: "Update", language: self.showView.lang))
                }
                .disabled(title.isEmpty || text.isEmpty || summary.isEmpty)
            }
            Spacer()
        }
        .padding()
    }
}
