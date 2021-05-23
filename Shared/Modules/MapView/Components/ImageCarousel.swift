//
//  ImageCarousel.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import SwiftUI

struct ImageCarousel: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    #if !os(watchOS)
    let screenSize : CGFloat = UIScreen.main.bounds.width
    #else
    let screenSize : CGFloat = WKInterfaceDevice.current().screenBounds.width
    #endif
    
    @Binding var images : [String]
    var body: some View {
        VStack(alignment : .leading) {
            
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(.white)
                    .contentShape(Rectangle())
            })
            .frame(width: 30, height: 30, alignment: .center)
            .padding([.top,.leading])
            
            
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(images, id: \.self) { image in
                        
                        Image(image)
                            .resizable()
                            .frame(width: screenSize, height: 200, alignment: .center)
                    }
                }
            }
            .padding()
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarousel(images: .constant(["Opéra1","Opéra1"]))
    }
}
