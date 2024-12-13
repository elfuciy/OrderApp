//
//  PresentSheetCell.swift
//  OrderApp
//
//  Created by Elsever on 09.12.24.
//

import UIKit

class PresentSheetCell: UITableViewCell {

    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewConfigure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func viewConfigure() {
        orderImage.contentMode = .scaleAspectFill
        orderImage.layer.cornerRadius = 10
    }
    
    func configure(order: Items) {
        orderImage.image = UIImage(named: order.image ?? "")
        nameLabel.text = order.itemName
        priceLabel.text = "\(order.price ?? 0) m"
        unitLabel.text = "Units: \(order.units ?? 0)"
    }

}