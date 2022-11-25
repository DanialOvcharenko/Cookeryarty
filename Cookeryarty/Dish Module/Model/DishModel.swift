//
//  DishModel.swift
//  Cookeryarty
//
//  Created by Mac on 17.11.2022.
//

import Foundation
import UIKit

enum TypeOfDish: String {
    case easy = "easy"
    case normal = "normal"
    case hard = "hard" 
}

struct DishModel: Identifiable, Equatable {
    
    var name: String
    var countryOfOrigin: String
    var image: UIImage
    var TypeOfDish: TypeOfDish
    var descript: String
    var recept: String
    var ingridients: [String]?
    var time: Int
    
    var id: String {
        name + countryOfOrigin
    }

}
