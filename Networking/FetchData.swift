//
//  FetchData.swift
//  shoppingApp
//
//  Created by Stevenson, Scott on 22/05/2023.
//

import Foundation

//fx asynchronous network call to fetch data from URL. Response data then decoded into the Response object using JSON decoding. products array updated with the products


func loadData(completion: @escaping ([Product]) -> Void) async {
    guard let url = URL(string: "https://dummyjson.com/products") else {
        print("Invalid URL")
        return
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            completion(decodedResponse.products)
        }
    } catch (let error){
        print(error)
    }
}

