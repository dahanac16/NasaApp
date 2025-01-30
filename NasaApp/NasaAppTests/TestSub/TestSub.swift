//
//  TestSub.swift
//  NasaAppTests
//
//  Created by Michel Arboleda on 28/01/25.
//

@testable import NasaApp

class TestSub {
    
    static func getDataNasa() -> NasaModel {
        return NasaModel(collection: Collection(href: "", items: [Item(data: [DataItem(album: [], center: "", date_created: "", description: "description", keywords: [], location: "", media_type: "", nasa_id: "", photographer: "", title: "title")], href: "", links: nil)], links: nil, metadata: nil, version: ""))
    }
    
    static func getDataNasaNil() -> NasaModel? {
        return nil
    }
}
