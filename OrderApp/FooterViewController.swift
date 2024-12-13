//
//  FooterViewController.swift
//  OrderApp
//
//  Created by Elsever on 10.12.24.
//

import UIKit

class FooterViewController: UITableViewHeaderFooterView {
    static let identifier = "FooterViewController"
    var fileManagerHelp = FileManagerHelp()
    var order = [Items]()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    lazy var labelPrice: UILabel = {
        let labelPrice = UILabel()
        labelPrice.textAlignment = .left
        labelPrice.textColor = .white
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.font = UIFont.systemFont(ofSize: 20)
        return labelPrice
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = .init(red: 134/255.0, green: 92/255.0, blue: 80/255.0, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
         
    override init(reuseIdentifier: String?) {
        super.init (reuseIdentifier: reuseIdentifier)
        contentView.addSubview(totalLabel)
        contentView.addSubview(labelPrice)
        contentView.addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            totalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            totalLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            labelPrice.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 12),
            labelPrice.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
            
            checkoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            checkoutButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
        checkoutButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        contentView.backgroundColor = .init(red: 30/255.0, green: 30/255.0, blue: 12/255.0, alpha: 1.0)
        fileManagerHelp.readOrder { order in
            self.order = order
        }
        labelPrice.text = String(calculate())

    }
    
    func calculate() -> Double {
        var sum: Double = 0
        for item in order {
            sum += (item.price ?? 0) * Double(item.units ?? 0)
            
        }
        return sum
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didTapButton() {
        if !order.isEmpty{
            labelPrice.textColor = .green
            labelPrice.text = "Payed"
        } else {
            labelPrice.textColor = .red
        }

    }
   
}
