//
//  ProductDetailView.swift
//  shoppingApp
//
//  Created by Hill, Sarah on 23/05/2023.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.brand)
                .font(.headline)
                .fontWeight(.bold)
            Text(product.title)
                .font(.subheadline)
                .opacity(0.6)
            Text("Description: \(product.description)")
                .font(.subheadline)
            Text("Price: £\(product.price)")
                .font(.subheadline)
            HStack {
                Text("Items left in stock:")
                    .font(.subheadline)
                Text("\(product.stock)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(product.images) { imageURL in
                        AsyncImage(url: imageURL) { image in
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
            .navigationTitle("Product Details")
        }
    }
    
    
    //needed to provide a product object to the preview 
    
    struct ProductDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleProduct = Product(
                brand: "Apple",
                title: "iPhone 9",
                description: "An apple mobile which is nothing like apple",
                price: 549,
                stock: 94,
                images: [
                    URL(string: "https://i.dummyjson.com/data/products/1/1.jpg")!,
                    URL(string: "https://i.dummyjson.com/data/products/1/2.jpg")!,
                    URL(string: "https://i.dummyjson.com/data/products/1/3.jpg")!,
                    URL(string: "https://i.dummyjson.com/data/products/1/4.jpg")!,
                ])
            
            return ProductDetailView(product: sampleProduct)
        }
    }
    
    
}
