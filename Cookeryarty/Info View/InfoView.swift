//
//  InfoView.swift
//  Cookeryarty
//
//  Created by Mac on 18.11.2022.
//

import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    
    var body: some View {
        ZStack {
            gradient
                .opacity(0.25)
                .ignoresSafeArea()
            
            ScrollView{
                HStack {
                    backButton
                    Spacer()
                }
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 3)
                VStack {
                    Text("Instructions must be here")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Images in this app is random quality")
                }
            }
            .ignoresSafeArea()
        }
    }
    
    
    private var backButton: some View {
        Button {
            vm.showInfoSheet = false
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
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
