//
//  HeadlineView.swift
//  Samachar
//
//  Created by Nazish Asghar on 24/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeadlineView: View {
    @Environment(\.presentationMode) var presentionMode
    @ObservedObject var news = NetworkCall()
    @State private var showing = false
    @Binding  var show : Bool
    @State private var selected : Article!
    var animation : Namespace.ID
     var countryCode = ["ae","ar","at","au","be","bg","br","ca","ch","cn","co","cu","cz","de","eg","fr","gb","gr","hk","hu","id","ie","il","in","it","jp","kr","lt","lv","ma","mx","my","ng","nl","no","nz","ph","pl","pt","ro","rs","ru","sa","se","sg","si","sk","th","tr","tw","ua","us","ve","za"]
    @State var selectCountry : String = "in"
  
    var body: some View {
        ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)){
            NavigationView{
            ScrollView{
                ForEach(news.headlineItems,id:\.self){ item in
                    HeadlineRow(headlineImage: item.urlToImage ?? "", headlinetitle: item.title, headlineDescription: item.description ?? "No Description", animation: animation)
                      
                        .onChange(of: news.country, perform: { value in
                            news.fetchHeadline()
                        })
                       
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                                show.toggle()
                            selected = item
                               
                            }
                        }
                } .onAppear{
                    news.fetchHeadline()
                }
                
               
            .navigationBarItems(trailing: Button(action: {
               showing = true
            }, label: {
                ZStack{
                    Capsule(style: .circular)
                    .frame(width: 100, height: 40)
                    Text("Region").foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }))
            }
            
            .navigationBarTitle("Headlines",displayMode: .large)
            }.opacity(show ? 0 : 1)
            .sheet(isPresented: $showing) {
                NavigationView{
                Form{
                Picker("Select Region", selection: $selectCountry){
                    ForEach(countryCode,id:\.self){ code in
                        Text(code)
                    }
                }
                }.navigationBarItems(trailing: Button(action: {
                    self.news.country = selectCountry
                    showing.toggle()
                }, label: {
                    Text("Done")
                }))
            }
            }
           
            
        if show {
           
            HeadLineDetailView( animation: animation, show: $show, item: $selected)
                
               
        }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.white.ignoresSafeArea(.all, edges: .all))
    }
}

struct HeadlineRow : View {
    
    let headlineImage : String
    let headlinetitle : String
    let headlineDescription : String
    var animation : Namespace.ID
    var body: some View{
        VStack{
            WebImage(url: URL(string: headlineImage)).resizable()
                .renderingMode(.original)
                .frame(width: UIScreen.main.bounds.width-10, height: 280)
                .aspectRatio(contentMode: .fill)
                
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .matchedGeometryEffect(id: headlineImage, in: animation)
                
            VStack(alignment:.leading,spacing:10){
                Text(headlinetitle).font(.title2)
                    .fontWeight(.heavy)
                    .lineLimit(3)
                    
                   
            }
        }
        
        .background(Color.white.opacity(1))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: .gray, radius: 10)
            .padding(.bottom)
    }
}
//struct HeadlineView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeadlineView()
//    }
//}

