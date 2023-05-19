# shoppingApp

Stage 1: Products List
_Show a list of products._
A product has a brand, title, description, price, stock level, images and other metadata.

>Created SwiftUI view that displays a list of products fetched from dummyJSON API. The view loads data asychronously
>Creation of two structs: Response and Product, These structs conform to Codable protocol and represent the structure of the JSON response we expect to receive.
>The properties of the Product struct have the same names and types as the corresponding keys in the JSON response. 
This allows the JSONDecoder to automatically map the JSON keys to the struct properties during decoding.
> Used URLSession, a class that allows you to perform network operations, such as making HTTP requests. 

