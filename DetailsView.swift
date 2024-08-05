//
//  DetailsView.swift
//  FetchCodingChallenge
//
//  Created by BLeDev on 8/2/24.
//

import SwiftUI

struct DetailsView: View {
    // this is needed since the structure of the JSON is represented as an array with one element
    @State private var mealDetails = MealDetails()
    var id: String
        
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: mealDetails.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
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
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                
                Text("Instructions")
                    .font(.title2)
                    .bold()
                Text(mealDetails.strInstructions)
                
                Divider()
                
                Text("Ingredients/Measurements")
                    .font(.title2)
                    .bold()
                
                ForEach(mealDetails.ingredients, id: \.self) { ingredient in
                    if !(ingredient == "") {
                        if let index = mealDetails.ingredients.firstIndex(of: ingredient) {
                            let measurement = mealDetails.measurements[index]
                            Text("\(ingredient): \(measurement)")
                        }
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
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(MealDetailsResponse.self, from: data) {
                for meal in decodedResponse.meals {
                    mealDetails = meal
                }
            }
            
        } catch {
        print("Invalid data")
        }
    }
}

// struct of the JSON data
struct MealDetailsResponse: Decodable {
    var meals: [MealDetails]
}

struct MealDetails: Decodable, Identifiable {
    var id: String
    var strMeal: String
    var strMealThumb: String
    var strInstructions: String
    var ingredients: [String]
    var measurements: [String]
    
    // https://stackoverflow.com/questions/68213705/swift-initialise-model-object-with-initfrom-decoder
    private enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .idMeal)
        self.strMeal = try values.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try values.decode(String.self, forKey: .strMealThumb)
        self.strInstructions = try values.decode(String.self, forKey: .strInstructions)
        // compact maps remove null values
        self.ingredients = (1...20).compactMap { index in
            try? values.decode(String.self, forKey: CodingKeys(rawValue: "strIngredient\(index)")!)
        }
        self.measurements = (1...20).compactMap { index in
            try? values.decode(String.self, forKey: CodingKeys(rawValue: "strMeasure\(index)")!)
        }
    }
    
    // created to be able to intialize variable mealDetails without the from decoder param
    init() {
        id = ""
        strMeal = ""
        strMealThumb = ""
        strInstructions = ""
        ingredients = []
        measurements = []
    }
}

#Preview {
    DetailsView(id: "52855")
}
