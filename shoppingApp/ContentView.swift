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
    let price: Int
    let stock: Int
    let images: [String]
}



struct ContentView: View {
    @State private var products = [Product]() //This property will hold the products loaded from JSON response
    
    
    
    var body: some View {
        NavigationView{
        
            List (products, id: \.id) { item in // id key path provides unique identifier for each item in the list
                VStack(alignment: .leading){
                    Text(item.brand)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(item.title)
                        .font(.subheadline)
                        .opacity(0.6)
                    Text("Description: \(item.description)")
                        .font(.subheadline)
                        
                    Text("Price: £\(item.price)")
                        .font(.subheadline)
                    HStack {
                                               Text("Items left in stock:")
                                                   .font(.subheadline)
                                               Text("\(item.stock)")
                                                   .font(.subheadline)
                                                   .foregroundColor(.blue)
                                           }
                    //asyncImage view to aynchronously load and display images from URLs. placeholder displayed while image is loading
                    ForEach(item.images, id: \.self) {imageURL in
                        AsyncImage(url: URL(string: imageURL)) {image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                }
            }
            
            //task modifier to call loadData.
            .task {
                await loadData()
            }
            .navigationTitle("Product List")
        }
    }
    //fx asynchronous network call to fetch data from URL. Response data then decoded into the Response object using JSON decoding. products array updated with the products
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
