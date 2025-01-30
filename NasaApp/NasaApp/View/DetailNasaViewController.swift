//
//  DetailMovieViewController.swift
//  NasaApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import UIKit

class DetailNasaViewController: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet weak var imageNasa: UIImageView!
    @IBOutlet weak var titleNasa: UILabel!
    @IBOutlet weak var descriptionNasa: UITextView!
    @IBOutlet weak var buttonStart: UIButton!
    // MARK: - Variables
    var dataDetail: Item?
    var checkFavorites: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
    }
    
    func initSetUp() {
        loadImage()
        setFavorites()
        setText()
    }
    
    private func setText() {
        self.titleNasa.text = dataDetail?.data?.first?.title ?? "Sin titulo"
        self.descriptionNasa.text = dataDetail?.data?.first?.description ?? "Sin descripción"
    }
    
    private func setFavorites() {
        checkFavorites = dataDetail?.data?[0].isFavorite
        buttonStart.setImage(checkFavorites ?? false ? UIImage(named: "start") : UIImage(named: "startEmpty"), for: .normal)
    }
    
    func loadImage() {
        if let urlString = dataDetail?.links?.first?.href {
            let formatUrl = urlString.replacingOccurrences(of: " ", with: "%20")
            if let imageUrl = URL(string: "\(formatUrl)") {
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.imageNasa.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func actionFavorites(_ sender: Any) {
        guard let _ = StateFavorites(rawValue: (sender as AnyObject).tag) else { return }
        let pressedCellButton: StateFavorites = (checkFavorites ?? false) ? .delete : .add
        switch pressedCellButton {
        case .add:
            dataDetail?.data?[0].mutateFavories(favorite: true)
            setFavorites()
        case .delete:
            dataDetail?.data?[0].mutateFavories(favorite: false)
            setFavorites()
        }
    }
}

