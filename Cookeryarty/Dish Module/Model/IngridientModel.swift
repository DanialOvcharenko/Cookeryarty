//
//  IngridientModel.swift
//  Cookeryarty
//
//  Created by Mac on 21.11.2022.
//

import Foundation

struct IngridientModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> IngridientModel {
        return IngridientModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}
