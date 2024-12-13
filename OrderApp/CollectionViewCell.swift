//
//  CollectionViewCollectionViewCell.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var addButton: UIButton!
    
    var price: Double?
    var imageString: String?
    var orderCallback: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 10
    }

    func configureCategory(image: String, category: String) {
        self.image.image = UIImage(named: image)
        categoryName.text = category
        addButton.isHidden = true
    }
    
    func configureMenu(order: Items) {
        self.image.image = UIImage(named: order.image ?? "")
            categoryName.text = order.itemName
            self.price = order.price
            self.imageString = order.image
            addButton.isHidden = false
        
    }
    
    @IBAction func makeOrder(_ sender: Any) {
        orderCallback?(tag)
    }
}
