//
//  MenuController.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import UIKit

class MenuController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    
    let managerHelp = FileManagerHelp()
    let colorConfigure = ColorConfigure()

    var menu = [Items]()
    var basket = [Items]()
    var category = [CategoryFood]()
    var count = 1
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        collection.delegate = self
        collection.dataSource = self
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        managerHelp.readOrder { busketOrder in
            self.basket = busketOrder
        }
        detailConfigure()
        
        managerHelp.getCategory { categoryFood in
            category = categoryFood
        }
    }
    
    func detailConfigure() {
        colorConfigure.setAppBackground(view)
        colorConfigure.setNavigationItem(navigationItem)
        title = "home"
    }
}

extension MenuController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.tag = indexPath.row
        cell.orderCallback = { index in
            let selectedItem = self.menu[index]
            let order: Items = .init(itemName: selectedItem.itemName ?? "", image: selectedItem.image ?? "", price: selectedItem.price ?? 0, units: 1)
            if self.basket.contains(where: {$0.itemName ==  selectedItem.itemName}) {
                self.count = self.basket[self.basket.firstIndex(where: {$0.itemName ==  selectedItem.itemName})!].units ?? 0
                self.basket[self.basket.firstIndex(where: {$0.itemName ==  selectedItem.itemName})!].units  = self.count+1
            } else {
                self.basket.append(order)
            }
               self.managerHelp.writeOrder(order: self.basket)
         }
        cell.configureMenu(order: menu[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}
