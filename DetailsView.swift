//
//  DetailsView.swift
//  FetchCodingChallenge
//
//  Created by BLeDev on 8/2/24.
//

import SwiftUI

struct DetailsView: View {
    @State private var mealDetails = MealDetails(idMeal: "", strMeal: "", strMealThumb: "", strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "")
    var id: String
    
    @State private var ingredients: [String] = []
    @State private var measurements: [String] = []
    
    var body: some View {
        // TODO: lookup the dessert by id as it will give more info
        ScrollView {
            AsyncImage(url: URL(string: mealDetails.strMealThumb)) { image in
                image.image?.resizable()
            }
            .frame(width: 350, height: 300)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(mealDetails.strMeal)
                    .font(.title)
                    .bold()

                Divider()
                
                Text("Instructions")
                .font(.title2)
                .bold()
                Text(mealDetails.strInstructions)
                
                Divider()
                
                Text("Ingredients/Measurements")
                .font(.title2)
                .bold()
                
             
                ForEach(ingredients, id: \.self) { ingredient in
                    let index = ingredients.firstIndex(of: ingredient)
                    if (!(ingredient == "")) {
                        Text("\(ingredient): \(measurements[index!])")
                    }
                }
                
            }
            .padding()
            
        }
        .task {
            await loadMealDetails(id: id)
        }
        
        
    }
    
    func loadMealDetails(id: String) async {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")
        else {
            print("Invalid URL")
            return
        }
        
        do {
            // we only want the data, not metadata
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(MealDetailsResponse.self, from: data) {
                for meal in decodedResponse.meals {
                    mealDetails.idMeal = meal.idMeal
                    mealDetails.strMeal = meal.strMeal
                    mealDetails.strMealThumb = meal.strMealThumb
                    mealDetails.strInstructions = meal.strInstructions
                    
                    ingredients.append(meal.strIngredient1)
                    ingredients.append(meal.strIngredient2)
                    ingredients.append(meal.strIngredient3)
                    ingredients.append(meal.strIngredient4)
                    ingredients.append(meal.strIngredient5)
                    ingredients.append(meal.strIngredient6)
                    ingredients.append(meal.strIngredient7)
                    ingredients.append(meal.strIngredient8)
                    ingredients.append(meal.strIngredient9)
                    ingredients.append(meal.strIngredient10)
                    ingredients.append(meal.strIngredient11)
                    ingredients.append(meal.strIngredient12)
                    ingredients.append(meal.strIngredient13)
                    ingredients.append(meal.strIngredient14)
                    ingredients.append(meal.strIngredient15)
                    ingredients.append(meal.strIngredient16)
                    ingredients.append(meal.strIngredient17)
                    ingredients.append(meal.strIngredient18)
                    ingredients.append(meal.strIngredient19)
                    ingredients.append(meal.strIngredient20)
                    
                    measurements.append(meal.strMeasure1)
                    measurements.append(meal.strMeasure2)
                    measurements.append(meal.strMeasure3)
                    measurements.append(meal.strMeasure4)
                    measurements.append(meal.strMeasure5)
                    measurements.append(meal.strMeasure6)
                    measurements.append(meal.strMeasure7)
                    measurements.append(meal.strMeasure8)
                    measurements.append(meal.strMeasure9)
                    measurements.append(meal.strMeasure10)
                    measurements.append(meal.strMeasure11)
                    measurements.append(meal.strMeasure12)
                    measurements.append(meal.strMeasure13)
                    measurements.append(meal.strMeasure14)
                    measurements.append(meal.strMeasure15)
                    measurements.append(meal.strMeasure16)
                    measurements.append(meal.strMeasure17)
                    measurements.append(meal.strMeasure18)
                    measurements.append(meal.strMeasure19)
                    measurements.append(meal.strMeasure20)
                }
            }
        } catch {
        print("Invalid data")
        }
    }
}

struct MealDetailsResponse: Codable {
    var meals: [MealDetails]
}

struct MealDetails: Codable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
    var strInstructions: String
    
    var strIngredient1: String
    var strIngredient2: String
    var strIngredient3: String
    var strIngredient4: String
    var strIngredient5: String
    var strIngredient6: String
    var strIngredient7: String
    var strIngredient8: String
    var strIngredient9: String
    var strIngredient10: String
    var strIngredient11: String
    var strIngredient12: String
    var strIngredient13: String
    var strIngredient14: String
    var strIngredient15: String
    var strIngredient16: String
    var strIngredient17: String
    var strIngredient18: String
    var strIngredient19: String
    var strIngredient20: String
    
    var strMeasure1: String
    var strMeasure2: String
    var strMeasure3: String
    var strMeasure4: String
    var strMeasure5: String
    var strMeasure6: String
    var strMeasure7: String
    var strMeasure8: String
    var strMeasure9: String
    var strMeasure10: String
    var strMeasure11: String
    var strMeasure12: String
    var strMeasure13: String
    var strMeasure14: String
    var strMeasure15: String
    var strMeasure16: String
    var strMeasure17: String
    var strMeasure18: String
    var strMeasure19: String
    var strMeasure20: String

   
}

#Preview {
    DetailsView(id: "52855")
}
