//
//  DishDeteilView.swift
//  Cookeryarty
//
//  Created by Mac on 17.11.2022.
//

import SwiftUI

struct DishDeteilView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    let dish: DishModel
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    
    var body: some View {
        ZStack {
            gradient
                .opacity(0.25)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    imageSection
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        titleSection
                        Divider()
                        descriptionSection
                        Divider()
                        ingridients
                        Divider()
                        timerSection
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .ignoresSafeArea()
            .background(.ultraThinMaterial)
            .overlay(backButton, alignment: .topLeading)
        }
    }
}

struct DishDeteilView_Previews: PreviewProvider {
    static var previews: some View {
        DishDeteilView(dish: DishDataService.dishes.first!)
            .preferredColorScheme(.light)
            .environmentObject(DishesViewModel())            
    }
}


extension DishDeteilView {
    
    private var imageSection: some View {
        Image(uiImage: dish.image)
            .resizable()
            .scaledToFill()
            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
            .clipped()
        
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dish.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            HStack {
                Text(dish.countryOfOrigin)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(dish.TypeOfDish.rawValue)")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(spacing: 10) {
                Text("Description")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Text(dish.descript)
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            
            Divider()
            
            VStack {
                Text("Recipe")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Text(dish.recept)
                    .font(.title3)
            }
            
        }
    }
    
    
    
    private var backButton: some View {
        Button {
            vm.sheetDishDeteil = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(Color("listRowBackground"))
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
    private var ingridients: some View {
        VStack(alignment: .leading) {
            Text ("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            HStack {
                
                AppendIngridientsView(dish: dish)
                
                VStack {
                    let ingrid = dish.ingridients ?? [""]
                    let ingridientsString = ingrid.joined(separator: "/ ")
                    Text(ingridientsString)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var timerSection: some View {
        TimerView(dish: dish)
    }
    
}
