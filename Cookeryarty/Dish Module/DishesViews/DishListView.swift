//
//  DishListView.swift
//  Cookeryarty
//
//  Created by Mac on 16.11.2022.
//

import SwiftUI

struct DishListView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    
    var body: some View {
        ZStack {
            
                dishList
                
            
        }
        .listStyle(PlainListStyle())
    }
}


struct DishListView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            DishListView()
                .environmentObject(DishesViewModel())
            
            DishListView()
                .environmentObject(DishesViewModel())
                .preferredColorScheme(.dark)
        }
    }
}




extension DishListView {
    
    
    
    private var dishList: some View {
        List {
            ForEach(vm.dishes) { dish in
                Button {
                    vm.showNextDish(dish: dish)
                } label: {
                    
                    HStack {
                        Image(uiImage: dish.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        
                            
                        VStack(alignment: .leading, spacing: 7) {
                            Text(dish.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Country: \(dish.countryOfOrigin)")
                        }
                        
                        Spacer()
                        
                        Divider()
                        
                        HStack {
                            Text("\(dish.TypeOfDish.rawValue)")
                        }
                        
                        
                    }
                    .padding(.vertical, 8)
                    
                }
            }
            .listRowBackground(Color.clear)
        }
    }
}
