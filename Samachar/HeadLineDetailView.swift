//
//  HeadLineDetailView.swift
//  Samachar
//
//  Created by Nazish Asghar on 25/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeadLineDetailView: View {
    var animation : Namespace.ID
    @Binding var show : Bool
      @Binding var item : Article!
    var body: some View {
        VStack(spacing:20){
           
            ZStack(alignment:.topTrailing){
            WebImage(url: URL(string: (item.urlToImage) ?? "" ))
                .resizable()
                .frame(width:UIScreen.main.bounds.width,height: 350)
                HStack(alignment:.top){
                    Spacer()
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.8)){
                        show.toggle()
                        }
                    }, label: {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding()
                            
                    })
                }
            }
            VStack{
            Text(item.title)
                .font(.title)

                .fontWeight(.heavy)
               
            Text(item.description ?? "")
                .fontWeight(.semibold)
                .lineLimit(200)
              
            if !item.url.isEmpty {
            Link("Read More Here", destination: URL(string: item.url)!)
            }
          Spacer()
                
            }
            
        }
        
    }
}
struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: 0, y: rect.height)
            let pt3 = CGPoint(x: rect.width, y: rect.height)
            let pt4 = CGPoint(x: rect.width, y: 150)
            path.move(to: pt4)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 45)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 45)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 45)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 45)
        }
    }
    
    
}
//struct HeadLineDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeadLineDetailView()
//    }
//}
