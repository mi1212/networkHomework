//
//  Beer.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 21.02.2023.
//

import Foundation

// MARK: - Beer
struct Beer: Codable {
    let id: Int
    let name, tagline, description: String
    let firstBrewed : String
    let imageURL: String?
    let ingredients: Ingredients
    let foodPairing: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case ingredients
        case foodPairing = "food_pairing"
    }
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String?
}
// MARK: - Malt
struct Malt: Codable {
    let name: String
    let amount: BoilVolume
}
// MARK: - Hop
struct Hop: Codable {
    let name: String
    let amount: BoilVolume
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double
}

// MARK: - Add
enum Add: String, Codable {
    case dryHop = "dry hop"
    case end = "end"
    case middle = "middle"
    case start = "start"
}

// MARK: - Attribute
enum Attribute: String, Codable {
    case aroma = "aroma"
    case attributeFlavour = "Flavour"
    case bitter = "bitter"
    case flavour = "flavour"
}
// MARK: - Unit
enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case litres = "litres"
}
