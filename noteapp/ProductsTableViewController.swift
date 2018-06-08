//
//  ProductTableViewController.swift
//  noteapp
//
//  Created by student24 on 2018. 6. 8..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    fileprivate var products: [Product]?
    fileprivate let identifer = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = [
            Product(name: "Student Hall - Korean Table", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "Student Hall - Noodle Road", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "Student Hall - Fry Fry", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "Student Hall - Hao Hao", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),
            Product(name: "Mom's Kitchen", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),
            Product(name: "Handong Lounge", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),
            Product(name: "InBreeze", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),
            Product(name: "Red Racoon", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4"),
            
        ]
    }
    
    // MARK: - UITableViewDataSource
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
    
    // MARK: - View Transfer
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
