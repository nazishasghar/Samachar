//
//  SearchNewsView.swift
//  Samachar
//
//  Created by Nazish Asghar on 27/06/21.
//

import SwiftUI

struct SearchNewsView: View {
    @ObservedObject var news = NetworkCall()
    @State var searchQuery = ""
    @State var searched  = false
    @State private var selectedItem : Article!
    @Namespace var animation
    @State var show = false
    var body: some View {
        ZStack{
        NavigationView{
            VStack(alignment:.leading){
                TextField("Search Anything", text: $searchQuery, onEditingChanged: {_ in
                
                }, onCommit: {
                    let trim = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
                    news.query = trim
                    if !searched {
                        withAnimation(.spring()){
                    searched.toggle()
                        }
                    }
                })
                
                
                .textFieldStyle(RoundedBorderTextFieldStyle())
              
                .padding()
      
                
                if searched {
                    ScrollView{
                    ForEach(news.searchItem,id:\.self) {item in
                        HeadlineRow(headlineImage: item.urlToImage ?? "", headlinetitle: item.title, headlineDescription: item.description ?? "", animation: animation)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    show.toggle()
                                    self.selectedItem = item
                                }
                            }
                            .onChange(of: news.query, perform: { value in
                                news.searchNews()
                            })
                           
                    }
                    } .onAppear{
                        news.searchNews()
                    }
                }
                Spacer()
            }.navigationTitle("Search News")
            .frame(alignment: .top)
        }.opacity(show ? 0 : 1)
            if show {
                HeadLineDetailView(animation: animation, show: $show, item: $selectedItem)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
    }
}

struct SearchNewsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNewsView()
    }
}
