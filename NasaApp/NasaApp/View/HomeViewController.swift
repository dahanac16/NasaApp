//
//  ViewController.swift
//  NasaApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import UIKit
import SwiftUI
import Alamofire

class HomeViewController: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var labelError: UILabel!
    // MARK: - Variables
    var vieWModel = HomeViewModel()
    var dataResult: [Item]? = []
    var dataFilter: [Item]? = []
    var dataFavorites: [Item]? = []
    var dataSelected: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.isHidden = true
        // init delegate
        search.delegate = self
        myCollection.delegate = self
        myCollection.dataSource = self
        // api
        vieWModel.getData(){ (data) in
            self.initCollectionView(data: data)
        } failure: { (error) in
            self.errorControl(error: error)
        }
    }
    
    func initCollectionView(data: NasaModel?) {
        labelError.isHidden = true
        self.dataResult = data?.collection?.items
        //validate data not nil
        guard let data = dataResult?.enumerated() else { return }
        //init favorites dafault false
        for (index, myItem) in data where myItem.data?.first?.isFavorite == nil {
            dataResult?[index].data?[0].mutateFavories(favorite: false)
        }
        dataFilter = dataResult
        myCollection.reloadData()
    }
    
    func errorControl(error: String) {
        labelError.isHidden = false
    }
    
}

// MARK: - Collection
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // number items load collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFilter?.count ?? 0
    }
    
    // data cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionNasaViewCell
        //init delegate favorites
        cell.delegate = self
        cell.productData = dataFilter?[indexPath.row]
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (myCollection.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    //select cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = dataFilter?[indexPath.row] else { return }
        dataSelected = data
        performSegue(withIdentifier: "viewDetail", sender: self)
    }
    
    //send parameters
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetail" {
            let navigateDetail = segue.destination as! DetailNasaViewController
            navigateDetail.dataDetail = dataSelected
        }
    }
    
    
}

// MARK: - Protocol
extension HomeViewController: ProtocolFavoritesDelegate {
    func validteFavoritesCell(_ cell: UICollectionViewCell, action button: StateFavorites) {
        //positio
        guard let row = myCollection.indexPath(for: cell)?.row else { return }
        switch button {
        case .add:
            dataFilter?[row].data?[0].mutateFavories(favorite: true)
        case .delete:
            dataFilter?[row].data?[0].mutateFavories(favorite: false)
        }
        dataFavorites = dataFilter
        myCollection.reloadData()
    }
}

// MARK: - Search
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataFilter = []
        if searchText == "" {
            dataFilter = dataFavorites
        } else {
            guard let data = dataFavorites else { return }
            for myData in data {
                let mytitle = myData.data?.first?.title ?? ""
                if (mytitle.lowercased().contains(searchText.lowercased())) {
                    dataFilter?.append(myData)
                }
            }
        }
        self.myCollection.reloadData()
    }
    
}
