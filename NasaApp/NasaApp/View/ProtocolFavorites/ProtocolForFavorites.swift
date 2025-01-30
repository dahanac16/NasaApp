//
//  ProtocolForFavorites.swift
//  MovieApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import SwiftUI

enum StateFavorite: Int {
    case addToFavorites
    case deleteToFavorites
}

protocol ProtocolFavoriteDelegate: AnyObject{
    func itemCellNasa(_ cell: UICollectionViewCell, didPressedButton button: StateFavorite)
}
