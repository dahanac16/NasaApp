//
//  CellMovieTableViewCell.swift
//  NasaApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import UIKit

class MyCollectionNasaViewCell: UICollectionViewCell {
    
    // MARK: - IBOulets
    @IBOutlet weak var imageNasa: UIImageView!
    @IBOutlet weak var titleNasa: UILabel!
    @IBOutlet weak var buttonFavorites: UIButton!
    // MARK: - Variables
    weak var delegate: ProtocolFavoritesDelegate?
    var checkFavorites: Bool?
    var productData: Item? {
        didSet {
            checkFavorites = productData?.data?[0].isFavorite
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageNasa.layer.cornerRadius = 15
    }
    
    private func setUpView() {
        loadImage()
        setFavorites()
        setText()
    }
    
    private func setText() {
        let text = productData?.data?.first?.title ?? "Sin titulo"
        titleNasa.text = text
    }
    
    private func setFavorites() {
        buttonFavorites.setImage(checkFavorites ?? false ? UIImage(named: "start") : UIImage(named: "startEmpty"), for: .normal)
        buttonFavorites.backgroundColor = UIColor(named: "#FF0000")
    }
    
    private func loadImage() {
        if let urlString = productData?.links?.first?.href {
            let formatUrl = urlString.replacingOccurrences(of: " ", with: "%20")
            if let imageUrl = URL(string: "\(formatUrl)") {
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.imageNasa.layer.cornerRadius = 15
                        self.imageNasa.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func actionFavorites(_ sender: Any) {
        guard let _ = StateFavorites(rawValue: (sender as AnyObject).tag) else { return }
        let pressedCellButton: StateFavorites = (checkFavorites ?? false) ? .delete : .add
        delegate?.validteFavoritesCell(self, action: pressedCellButton)
    }
}


