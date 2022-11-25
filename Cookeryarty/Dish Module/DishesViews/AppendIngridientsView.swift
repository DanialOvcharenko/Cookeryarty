//
//  AddIngridientsView.swift
//  Cookeryarty
//
//  Created by Mac on 22.11.2022.
//

import SwiftUI

struct AppendIngridientsView: View {
    
    @EnvironmentObject var vm: DishesViewModel
    let dish: DishModel
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        Button {
            
            showAlert.toggle()
            
            vm.arrayOfIngridients.removeAll()
            vm.ingriToMyArray(ingridients: dish.ingridients ?? ["None"])
            vm.addItemsFromRecept(titles: vm.arrayOfIngridients)

        } label: {
            Image(systemName: "plus")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Cool"),
                message: Text("Ingridients are added to the list"),
                dismissButton: .default(Text("OK"))
            )
        })
    }
}

struct AppendIngridientsView_Previews: PreviewProvider {
    static var previews: some View {
        AppendIngridientsView(dish: DishDataService.dishes.first!)
            .environmentObject(DishesViewModel())
    }
}
