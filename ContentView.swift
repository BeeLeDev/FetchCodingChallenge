//
//  ContentView.swift
//  FetchCodingChallenge
//
//  Created by BLeDev on 8/1/24.
//

/*
 https://fetch-hiring.s3.amazonaws.com/iOS+coding+exercise.pdf
 */

//

import SwiftUI

struct ContentView: View {
    @State private var meals = [Meal]()
    
    var body: some View {
        Text("Desserts")
            .font(.title)
            .bold()
        
        // sort list in alphabetical order
        List(meals.sorted(by: { $0.strMeal < $1.strMeal }), id: \.idMeal) { meal in
            VStack {
                Text(meal.strMeal)
            }
        }
        .scrollContentBackground(.visible)
        .task {
            await loadData()
        }
        
        // ...
    }
    
    func loadData() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") 
        else {
            print("Invalid URL")
            return
        }
        
        do {
            // we only want the data, not metadata
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                meals = decodedResponse.meals
            }
            
        } catch {
        print("Invalid data")
        }
    }
    
    // ...
}

struct Response: Codable {
    var meals: [Meal]
}

struct Meal: Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}

#Preview {
    ContentView()
}
