//
//  ContentView.swift
//  Samachar
//
//  Created by Nazish Asghar on 24/06/21.
//

import SwiftUI
struct ContentView: View {
    @Namespace var animation
    @State private var show = false
    var body: some View {
        TabView{
        HeadlineView(show: $show, animation:animation)
            .tabItem { Image(systemName: "newspaper.fill") }
            
        SearchNewsView()
                .tabItem { Image(systemName: "magnifyingglass") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
