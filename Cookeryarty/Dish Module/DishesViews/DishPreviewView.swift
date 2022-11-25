//
//  DishPreviewView.swift
//  Cookeryarty
//
//  Created by Mac on 18.11.2022.
//

import SwiftUI

struct DishPreviewView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    
    let dish: DishModel
    
    var body: some View {

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 16) {
                        imageSection
                        titleSection
                    }
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Button {
                            vm.toggleInfoSheet() 
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color("AccentColor"))
                        }
                        .sheet(isPresented: $vm.showInfoSheet) {
                            InfoView()
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        learnMore
                        HStack {
                            previousButton
                            nextButton
                        }
                    }
                    
                }
                
                Text(dish.descript)
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                
                myIngridientsButton
                    .offset(y: 5)

                
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 95)
            )
        .cornerRadius(10)
        
        
        
    }
}

struct DishPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            DishPreviewView(dish: DishDataService.dishes.first!)
        }
        .environmentObject(DishesViewModel())
    }
}


extension DishPreviewView {
    
    private var imageSection: some View {
        ZStack{
            if let imageName = dish.image {
                Image(uiImage: imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AccentColor"), lineWidth: 5))
                    .shadow(radius: 10)
            }
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(dish.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Country: \(dish.countryOfOrigin)")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMore: some View {
        Button {
            vm.sheetDishDeteil = dish
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var previousButton: some View {
        Button {
            vm.prevButtonPressed()
        } label: {
            Text("Prev")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(width: 47, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(width: 47, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
    private var myIngridientsButton: some View {
        Button {
            vm.toggleIngridientsSheet()
        } label: {
            Text("My Ingridients List")
                .font(.headline)
                .frame(height: 35)
                .frame(maxWidth: .infinity)
                //.background(Color("AccentColor"))
                //.overlay(RoundedRectangle(cornerRadius: 10)
            //.stroke(Color("AccentColor"), lineWidth: 5))
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $vm.showIngridientsSheet) {
            IngridientsListView()
        }
    }
    
}

        
