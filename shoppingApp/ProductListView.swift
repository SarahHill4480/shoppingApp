//
//  ContentView.swift
//  shoppingApp
//
//  Created by Hill, Sarah on 17/05/2023.
//

import SwiftUI


struct ProductListView: View {
    @State private var products = [Product]() //This property will hold the products loaded from JSON response
    let productInteractor = RealProductInteractor()
    
    
    var body: some View {
        NavigationView{
        
            List (products) { item in
                NavigationLink(destination: ProductDetailView(product: item)) {
                    VStack(alignment: .leading){
                        Text(item.brand)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(item.title)
                            .font(.subheadline)
                            .opacity(0.6)
                        
                        Text("Price: £\(item.price)")
                            .font(.subheadline)
                      
                        //asyncImage view to aynchronously load and display images from URLs. placeholder displayed while image is loading
                        if let firstImageURL = item.images.first {
                         AsyncImage(url: firstImageURL) { image in
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
            }
            
            //task modifier to call loadData.
            .task {
                self.products = await productInteractor.loadData()
               
                
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
