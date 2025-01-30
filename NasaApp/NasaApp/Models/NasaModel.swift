//
//  MovieModel.swift
//  NasaApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import Foundation
import SwiftUI

struct NasaModel: Decodable {
    let collection: Collection?
}

struct Collection: Decodable {
    let href: String?
    let items: [Item]?
    let links: [LinkX]?
    let metadata: Metadata?
    let version: String?
}

struct Item: Decodable {
    var data: [DataItem]?
    let href: String?
    let links: [Link]?
}

struct LinkX: Decodable {
    let href: String?
    let prompt: String?
    let rel: String?
}

struct Metadata: Decodable {
    let total_hits: Int?
}

struct DataItem: Decodable {
    let album: [String]?
    let center: String?
    let date_created: String?
    let description: String?
    let keywords: [String]?
    let location: String?
    let media_type: String?
    let nasa_id: String?
    let photographer: String?
    let title: String?
    private(set) var isFavorite: Bool? = false
    
    mutating func mutateFavories(favorite: Bool?) {
        isFavorite = favorite
    }
    
}

struct Link: Decodable {
    let href: String?
    let render: String?
    let rel: String?
}



