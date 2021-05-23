//
//  ShowDetailsView.swift
//  SuperRun Extension
//
//  Created by DerouicheElyes on 23/5/2021.
//

import SwiftUI

struct ShowDetailsView: View {
    @ObservedObject var viewModel : SheetViewModel
    
    @State private var presentImageViewer = false
    
    var closeCompletion : () -> ()
    
    @ViewBuilder
    var CityViewRender : some View {
        HStack(alignment : .top) {
            
            VStack{
                
                VStack(alignment : .leading){
                    Text(viewModel.cityName)
                        .font(.headline)
                    
                    if viewModel.isCity {
                        Text("\(viewModel.locations) locations")
                            .font(.footnote)
                        Text("Distance : \(viewModel.distance)")
                            .font(.caption2)
                    }
                }
                .padding(.bottom)
                
                
                ZStack{
                    ForEach(viewModel.images.indices, id : \.self ) { index in
                        Image(viewModel.images[index])
                            .resizable()
                            .frame(width: 80, height: 70, alignment: .center)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 1)
                            .offset(x: -CGFloat(index * 5), y: CGFloat(index * 1))
                    }
                }
                .onTapGesture {
                    self.presentImageViewer.toggle()
                }
            }
            .padding(.horizontal, 5)
            .fullScreenCover(isPresented: $presentImageViewer) {
                ImageCarousel( images: $viewModel.images)
            }
            
            Spacer()
        }
        
    }
    
    var body: some View {
        CityViewRender
    }
}

struct ShowDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailsView(viewModel: .init(location: City(city: "Tunisia", isOnline: true, distance: 23, locations: [])), closeCompletion: {
            
        })
    }
}
