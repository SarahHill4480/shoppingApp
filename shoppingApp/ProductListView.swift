//
//  ContentView.swift
//  shoppingApp
//
//  Created by Hill, Sarah on 17/05/2023.
//

import SwiftUI


struct ProductListView: View {
    @State private var products = [Product]() //This property will hold the products loaded from JSON response
    
    
    
    var body: some View {
        NavigationView{
        
            List (products) { item in // id key path provides unique identifier for each item in the list
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
                    ForEach(item.images) {imageURL in
                        AsyncImage(url: imageURL) {image in
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
                await loadData { products in
                    // Assign the received products to the self.products property
                    self.products = products
                }
            }
            .navigationTitle("Product List")
        }
    }

    
    
    
    
    
    
    
    
    
    struct ProductListView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
    
}
