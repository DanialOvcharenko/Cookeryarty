//
//  DishView.swift
//  Cookeryarty
//
//  Created by Mac on 18.11.2022.
//

import SwiftUI
import MapKit

struct DishesView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    let maxWidthForIpad: CGFloat = 700
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)

    var body: some View {
            ZStack {
                
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    header
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                    Spacer()
                    dishPreviewStack
                }
                
            }
            .sheet(item: $vm.sheetDishDeteil, onDismiss: nil) { dish in
                DishDeteilView(dish: dish)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        DishesView()
            .environmentObject(DishesViewModel())
    }
}


extension DishesView {

    private var header: some View {

            VStack {
                Button(action: vm.toggleDishesList) {
                    Text(vm.currentDish.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showDishesList ? 180 : 0))
                        }
                }

                if vm.showDishesList {
                    DishListView()
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    
    }

    

    private var dishPreviewStack: some View {
        ZStack{
            ForEach(vm.dishes) { dish in
                if vm.currentDish == dish {
                    DishPreviewView(dish: dish)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

}

