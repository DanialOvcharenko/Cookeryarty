//
//  AddIngridientsView.swift
//  Cookeryarty
//
//  Created by Mac on 23.11.2022.
//

import SwiftUI

struct AddIngridientsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: DishesViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
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
                    TextField("Type ingridient here...", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AccentColor"), lineWidth: 5)
                        )
                    
                    Button {
                        saveButtonPressed()
                    } label: {
                        Text("Save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Add an ingridient 🍔")
        .alert(isPresented: $showAlert, content: getAlert)
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            vm.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 1 {
            alertTitle = "You can't add empty item Type the name of the item"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}



struct AddIngridientsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddIngridientsView()
        }
        .environmentObject(DishesViewModel())
    }
}
