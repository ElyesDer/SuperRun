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
    @Published var cityName : String
    @Published var locations : Int
    @Published var distance : Int
    
    init(location : PinPoint) {
        self.cityName = location.city
        self.locations = location.locations.count
        self.distance = location.distance
        self.images = ["Opéra1","Opéra2","Opéra1","Opéra2"]
    }
}

struct BottomSheet: View {
    @State var txt = ""
    @Binding var offset: CGFloat
    var value: CGFloat
    
    
    @StateObject var viewModel = SheetViewModel(location: .init(city: "Tunisia", isOnline: true, distance: 234, locations: [.init(name: "Sidi bou Said", latitude: 33.12332, longitude: 10.12312)]))
    
    @State private var presentImageViewer = false
    
    @ViewBuilder
    var CityViewRender : some View {
        VStack(alignment : .leading) {
            
            HStack{
                
                VStack(alignment : .leading){
                    Text("City name")
                        .font(.headline)
                    Text("\(0) exciting locations")
                        .font(.footnote)
                    Text("Distance cover : ")
                        .font(.caption2)
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
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: 30, height: 5, alignment: .center)
                .cornerRadius(3.0)
                .padding(.bottom, 5)
            
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
        }
        .padding()
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
        
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(offset: .constant(.zero), value: .zero)
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
