//
//  ListRowView.swift
//  Cookeryarty
//
//  Created by Mac on 21.11.2022.
//

import SwiftUI

struct ListRowView: View {
    
    let item: IngridientModel
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    
    var body: some View {
        
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? Color("AccentColor") : .black)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = IngridientModel(title: "beetroot", isCompleted: true)
    static var item2 = IngridientModel(title: "meet", isCompleted: false)
    static var item3 = IngridientModel(title: "Onion", isCompleted: true)
    static var item4 = IngridientModel(title: "Cucumber", isCompleted: false)
    
    static var previews: some View {
        Group {
            ListRowView(item: item1)
                .previewLayout(.sizeThatFits)
            ListRowView(item: item2)
            ListRowView(item: item3)
            ListRowView(item: item4)
        }
        .previewLayout(.sizeThatFits)
    }
}
