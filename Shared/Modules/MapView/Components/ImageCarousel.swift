//
//  ImageCarousel.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 23/5/2021.
//

import SwiftUI

struct ImageCarousel: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var images : [String]
    var body: some View {
        VStack(alignment : .leading) {
            
            
            Image(systemName: "multiply")
                .resizable()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(.white)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
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
