//
//  ContentView.swift
//  shoppingApp
//
//  Created by Hill, Sarah on 17/05/2023.
//

import SwiftUI

struct Response: Codable {
    var products: [Product]
}

struct Product: Codable {
    let id: Int
    let brand: String
    let title: String
    let description: String
    let price: Float
    let stock: Int
    let images: [String]
}



struct ContentView: View {
    
    @State private var products = [Product]()
    
    
    
    var body: some View {
        List (products, id: \.id) { item in
            VStack(alignment: .leading){
                Text(item.brand)
                Text(item.title)
                Text(item.description)
                Text(String(item.price))
                Text(String(item.stock))
                
                
                
            }
        }
        .task {
            await loadData()
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                products = decodedResponse.products
            }
        } catch (let error){
            print(error)
        }
    }
    

    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
