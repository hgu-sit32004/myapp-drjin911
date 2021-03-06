//
//  ProductTableViewController.swift
//  noteapp
//
//  Created by student24 on 2018. 5. 8..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    fileprivate var products: [Product]?
    fileprivate let identifer = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = [
            Product(name: "Hyundai Motors - North Pohang", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "Kia Motors - Yangdeok", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "Chevrolet - Jangryang", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "Ssangyoung - North Pohang", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),

            
        ]
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        guard let products = products else { return cell }
        
        cell.textLabel?.text = products[(indexPath as NSIndexPath).row].name
        
        if let imageName = products[(indexPath as NSIndexPath).row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell;
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let productVC = segue.destination as? ProductViewController {
                productVC.product = products?[(indexPath as NSIndexPath).row]
            }
        }
    }
}
