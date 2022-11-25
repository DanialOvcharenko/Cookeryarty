//
//  CookeryartyApp.swift
//  Cookeryarty
//
//  Created by Mac on 16.11.2022.
//

import SwiftUI

@main
struct CookeryartyApp: App {
    
    @State private var vm = DishesViewModel()
    
    var body: some Scene {
        WindowGroup {
            DishesView()
                .environmentObject(vm)
                .tabItem {
                    Label("Dishes", systemImage: "list.dash")
                }
        }
    }
}
