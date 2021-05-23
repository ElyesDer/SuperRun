//
//  BottomSheet.swift
//  SuperRun (iOS)
//
//  Created by DerouicheElyes on 22/5/2021.
//

import Foundation
import SwiftUI


class SheetViewModel: ObservableObject {
    @Published var images = [String]()
    @Published var cityName : String = ""
    @Published var locations : Int = 0
    @Published var distance : Int = 0
    
    @Published var isCity = true
    
    init(location : City?) {
        isCity = true
        if let location = location {
            self.cityName = location.city
            self.locations = location.locations.count
            self.distance = location.distance
            self.images = ["Basilique de Fourvière1", "Opéra1","Place Bellecour2", "Place des Jacobins1", "Place des Terreaux1"]
        }
    }
    
    init(location : Location) {
        isCity = false
        self.cityName = location.name
        for i in 1...2 {
            self.images.append(self.cityName + i.description)
        }
    }
}

struct BottomSheet: View {
    
    @Binding var offset: CGFloat
    var value: CGFloat
    
    
    @ObservedObject var viewModel : SheetViewModel
    
    @State private var presentImageViewer = false
    
    var closeCompletion : () -> ()
    
    @ViewBuilder
    var CityViewRender : some View {
        VStack(alignment : .leading) {
            
            HStack{
                
                VStack(alignment : .leading){
                    Text(viewModel.cityName)
                        .font(.headline)
                    
                    if viewModel.isCity {
                        Text("\(viewModel.locations) exciting locations")
                            .font(.footnote)
                        Text("Distance cover : \(viewModel.distance)")
                            .font(.caption2)
                    } else {
                        Spacer()
                    }
                }
                
                Spacer()
                
                ZStack{
                    ForEach(viewModel.images.indices, id : \.self ) { index in
                        Image(viewModel.images[index])
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 1)
                            .offset(x: -CGFloat(index * 3), y: CGFloat(index * 3))
                    }
                }
                .onTapGesture {
                    self.presentImageViewer.toggle()
                }
            }
            .padding(.horizontal, 5)
        }
        
        .background(BlurView(style: .systemMaterial))
        
    }
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center){
                Spacer ()
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 30, height: 5, alignment: .center)
                    .cornerRadius(3.0)
                    .padding(.bottom, 5)
                
                
                Spacer ()
                Button (action: closeCompletion, label: {
                    ZStack{
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                        
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 8, height: 8, alignment: .center)
                        
                    }
                    .frame(width: 20, height: 20, alignment: .center)
                })
                
            }
            
            CityViewRender
                .fullScreenCover(isPresented: $presentImageViewer) {
                    ImageCarousel( images: $viewModel.images)
                }
            
            Button(action: {}, label: {
                ZStack{
                    
                    Rectangle()
                        .cornerRadius(15)
                        .frame( height: 30, alignment: .center)
                    
                    Text("Click to show in ..")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
            })
            .padding(.top)
        }
        .padding()
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
        
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(offset: .constant(.zero), value: .zero, viewModel: .init(location: .init(city: "Tunisia", isOnline: true, distance: 234, locations: [], latitude: 33.234, longitude: 10.1234)), closeCompletion: {
            
        })
    }
}




struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
