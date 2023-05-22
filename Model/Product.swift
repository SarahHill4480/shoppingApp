//
//  Model.swift
//  shoppingApp
//
//  Created by Stevenson, Scott on 17/05/2023.
//

import Foundation

struct Product: Codable, Identifiable {
    let id = UUID()
    let brand: String
    let title: String
    let description: String
    let price: Int
    let stock: Int
    let images: [URL]
}


extension URL: Identifiable {
  public var id: String {
    return self.absoluteString
  }
}
