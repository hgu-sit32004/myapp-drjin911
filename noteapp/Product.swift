//
//  Product.swift
//  noteapp
//
//  Created by student24 on 2018. 6. 8..
//  Copyright © 2018년 student24. All rights reserved.
//


import Foundation

class Product {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName

    }
}

	
