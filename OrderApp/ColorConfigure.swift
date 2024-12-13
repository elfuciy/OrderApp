//
//  ColorConfigure.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import Foundation
import UIKit

class ColorConfigure {
    func setGradientBackground(_ view: UIView) {
        let colorTop =  UIColor(red: 30/255.0, green: 19/255.0, blue: 12/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 134/255.0, green: 92/255.0, blue: 80/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setButton(_ button: UIButton) {
        let colorTop =  UIColor(red: 104.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 58.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = button.bounds
        
        button.layer.insertSublayer(gradientLayer, at:0)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
    }
    
    func setAppBackground(_ view: UIView) {
        view.backgroundColor = .init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
    }
    
    func setNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func setLabel(label: UILabel, color: UIColor, size: CGFloat) {
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size)
        label.isHidden = true
    }
    
    func selTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        
    }
}
