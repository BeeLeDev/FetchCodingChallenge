//
//  ListRowView.swift
//  FetchCodingChallenge
//
//  Created by BLeDev on 8/4/24.
//

import SwiftUI

struct ListRowView: View {
    let meal: Meal
    
    var body: some View {
        // row view in list of meal
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 50, maxHeight: 50)
            
            Text(meal.strMeal)
        }
    }
}

#Preview {
    ListRowView(meal: Meal(strMeal: "Tarte Tatin", strMealThumb: "https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg", idMeal: "52909"))
}
