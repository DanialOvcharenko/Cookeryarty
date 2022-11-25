//
//  dishViewModel.swift
//  Cookeryarty
//
//  Created by Mac on 17.11.2022.
//

import Foundation
import SwiftUI

class DishesViewModel: ObservableObject {

    //MARK: - VM for Dish
    
    // All dishes
    @Published var dishes: [DishModel]
    
    @Published var currentDish: DishModel
    
    
    //Show list of locations
    @Published var showDishesList: Bool = false
    
    @Published var showInfoSheet: Bool = false
    
    @Published var showIngridientsSheet: Bool = false
    
    //Show dish detail via sheet
    @Published var sheetDishDeteil: DishModel? = nil
    
    init() {
        let dishes = DishDataService.dishes
        self.dishes = dishes
        self.currentDish = dishes.first!
        
        getItems()
    }
    
    
    func toggleDishesList() {
        withAnimation(.easeInOut) {
            showDishesList = !showDishesList
        }
    }
    
    func toggleInfoSheet() {
        withAnimation(.easeInOut) {
            showInfoSheet = !showInfoSheet
        }
    }
    
    func toggleIngridientsSheet() {
        withAnimation(.easeInOut) {
            showIngridientsSheet = !showIngridientsSheet
        }
    }
    
    
    func showNextDish(dish: DishModel) {
        withAnimation(.easeInOut) {
            currentDish = dish
            showDishesList = false
        }
    }
    
    
    
    
    func nextButtonPressed() {
        
        // Get the current index
        guard let currentIndex = dishes.firstIndex(where: { $0 == currentDish }) else {
            print("Could not find current index in locations array!")
            return
        }
        
        // Check if currentIndex is valid
        let nextIndex = currentIndex + 1
        guard dishes.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstDish = dishes.first else { return }
            showNextDish(dish: firstDish)
            return
        }
        
        // Next index IS valid
        let nextDish = dishes[nextIndex]
        showNextDish(dish: nextDish)
        
    }
    
    func prevButtonPressed() {
        
        // Get the current index
        guard let currentIndex = dishes.firstIndex(where: { $0 == currentDish }) else {
            print("Could not find current index in locations array!")
            return
        }
        
        // Check if currentIndex is valid
        let prevIndex = currentIndex - 1
        guard dishes.indices.contains(prevIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let lastDish = dishes.last else { return }
            showNextDish(dish: lastDish)
            return
        }
        
        // Next index IS valid
        let prevDish = dishes[prevIndex]
        showNextDish(dish: prevDish)
        
    }
    
    
    
    //MARK: - VM for Ingridiwnts
    
    @Published var arrayOfIngridients: [String] = [""]
    @Published var typeOfSorting: String = "Show all"
    
    @Published var ingridients: [IngridientModel] = []
    @Published var ResultArr: [IngridientModel] = []{
        didSet {
            saveItems()
        }
    }
    
    let ingridientsKey1: String = "ingridients_resultArr"
    let ingridientsKey2: String = "ingridients_items"
    
    func getItems() {

        guard
            let data = UserDefaults.standard.data(forKey: ingridientsKey1),
            let savedIngridients1 = try? JSONDecoder().decode([IngridientModel].self, from: data)
        else { return }
        
        guard
            let data2 = UserDefaults.standard.data(forKey: ingridientsKey2),
            let savedIngridients2 = try? JSONDecoder().decode([IngridientModel].self, from: data2)
        else { return }
                
        self.ResultArr = savedIngridients1
        self.ingridients = savedIngridients2
    }
    
    func deleteItem(indexSet: IndexSet) {
        ResultArr.remove(atOffsets: indexSet)
        ingridients.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        ResultArr.move(fromOffsets: from, toOffset: to)
        ingridients.move(fromOffsets: from, toOffset: to)
    }
    
    
    
    
    
    
    
    
    func addItem(title: String) {
        let newItem = IngridientModel(title: title, isCompleted: false)
        ResultArr.append(newItem)
        ingridients.append(newItem)
    }
    
    func addItemsFromRecept(titles: [String]) {
        for title in titles {
            let newItem = IngridientModel(title: title, isCompleted: false)
            ResultArr.append(newItem)
            ingridients.append(newItem)
        }
    }
    
    func ingriToMyArray (ingridients: [String]) {
        for ingridient in ingridients {
            arrayOfIngridients.append(ingridient)
        }
    }
    
    
    
    
    
    func updateItem(item: IngridientModel) {
        
        if let index = ResultArr.firstIndex(where: { $0.id == item.id }) {
            ResultArr[index] = item.updateCompletion()
        }
        if let index = ingridients.firstIndex(where: { $0.id == item.id }) {
            ingridients[index] = item.updateCompletion()
        }
    }
    
    
    
    
    func filterIsCompleted() {
        ResultArr = ingridients.filter({ (item) -> Bool in
            return item.isCompleted == true
        })
    }
    
    func filterIsNotCompleted() {
        ResultArr = ingridients.filter({ (item) -> Bool in
            return item.isCompleted == false
        })
    }
    
    func sortAZ() {
        ResultArr = ingridients.sorted(by: { $0.title.lowercased() < $1.title.lowercased() })
    }
    
    func sortZA() {
        ResultArr = ingridients.sorted(by: { $0.title.lowercased() > $1.title.lowercased() })
    }
    
    func updateResultArray() {
        ResultArr = ingridients
    }
    
    func deleteAll() {
        ResultArr.removeAll()
        ingridients.removeAll()
    }
    
    
    
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(ResultArr) {
            UserDefaults.standard.set(encodedData, forKey: ingridientsKey1)
        }
        if let encodedData = try? JSONEncoder().encode(ingridients) {
            UserDefaults.standard.set(encodedData, forKey: ingridientsKey2)
        }
    }
    
}
