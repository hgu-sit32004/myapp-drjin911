//
//  ProductViewController.swift
//  noteapp
//
//  Created by student24 on 2018. 6. 8..
//  Copyright © 2018년 student24. All rights reserved.
//

import UIKit
import MapKit


class ProductViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 36.102337, longitude: 129.389275)
        
        let regionRadius: CLLocationDistance = 500
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
            
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)

        
        if let imageName = product?.fullscreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: AnyObject) {
        print("Add to cart successfully")
    }
}

