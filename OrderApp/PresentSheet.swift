//
//  PresentSheet.swift
//  OrderApp
//
//  Created by Elsever on 09.12.24.
//

import UIKit

class PresentSheet: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let colorConfigure = ColorConfigure()
    let fileManagerHelp = FileManagerHelp()
    
    var basket = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FooterViewController.self, forHeaderFooterViewReuseIdentifier: "FooterViewController")
        fileManagerHelp.readOrder { order in
            self.basket = order
        }
        colorConfigure.setAppBackground(view)
    }
}

extension PresentSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresentSheetCell", for: indexPath) as! PresentSheetCell
        cell.configure(order: basket[indexPath.row])
        cell.callBackPlus = {
            if self.basket[indexPath.row].units ?? 0 > 1 {
                tableView.beginUpdates()
                self.basket[indexPath.row].units = self.basket[indexPath.row].units! + 1
                tableView.endUpdates()
                tableView.reloadData()
                self.fileManagerHelp.writeOrder(order: self.basket)

            }
        }
        cell.callBackMinus = {
            if self.basket[indexPath.row].units ?? 0 > 1 {
                tableView.beginUpdates()
                self.basket[indexPath.row].units = self.basket[indexPath.row].units! - 1
                tableView.reloadSections(IndexSet(integer: 0), with: .none)
                tableView.endUpdates()
                tableView.reloadData()
                self.fileManagerHelp.writeOrder(order: self.basket)
            } else {
                tableView.beginUpdates()
                self.basket.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                tableView.endUpdates()
                tableView.reloadData()
                self.fileManagerHelp.writeOrder(order: self.basket)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterViewController") as! FooterViewController
        footer.getData(order: basket)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                tableView.beginUpdates()
                basket.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                tableView.endUpdates()
                fileManagerHelp.writeOrder(order: basket)
        }
    }

   
}
