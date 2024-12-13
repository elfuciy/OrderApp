//
//  MainController.swift
//  OrderApp
//
//  Created by Elsever on 08.12.24.
//

import UIKit

class MainController: UIViewController {
    
    var categoryItems: [CategoryFood] = []
    var colorConfigure = ColorConfigure()
    var managerHelp = FileManagerHelp()
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket"), style: .plain, target: self, action: #selector(basket))
        detailConfigure()
        
        managerHelp.getCategory { category in
            categoryItems = category
        }
    }
    
    func detailConfigure() {
        colorConfigure.setAppBackground(view)
        colorConfigure.setNavigationItem(navigationItem)
        title = "home"
    }
    
    @objc func basket() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "myVCID") as! PresentSheet
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 10
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        self.present(controller, animated: true)
    }
}

extension MainController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configureCategory(image: categoryItems[indexPath.row].image ?? "", category: categoryItems[indexPath.row].categoryName ?? "")
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let controller = storyboard?.instantiateViewController(withIdentifier: "MenuController") as! MenuController
                controller.menu = categoryItems[indexPath.row].items ?? []
                controller.title = categoryItems[indexPath.row].categoryName
                navigationController?.show(controller, sender: nil)
            }
    
}
